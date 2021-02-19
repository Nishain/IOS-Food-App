//
//  CustomTableViewController.swift
//  Food App
//
//  Created by Nishain on 2/11/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import FirebaseStorage
import SkeletonView
class CustomTableViewController: UITableViewController {
    var currentLocation:CLLocation?
    
    
    @IBSegueAction func onClick(_ coder: NSCoder, sender: Any?) -> UIViewController? {
        let detailsScreen = DetailsViewController(coder: coder)
        let selectedFood = data[(sender as! UIButton).tag]
        detailsScreen?.food = Food(image: selectedFood.image, title: selectedFood.title, ingredients: selectedFood.ingredients, distance:selectedFood.distance, price: selectedFood.price,location: selectedFood.location)
        detailsScreen?.userCurrentLocation = currentLocation?.coordinate
        return detailsScreen
    }
    var data:[Food] = [
        /*Food(image: #imageLiteral(resourceName: "burger1"), title: "Burger 1", ingredients: "list of ingredients 1", distance: 2.3,price: 650),
        Food(image: #imageLiteral(resourceName: "burger2"), title: "Burger 2", ingredients: "list of ingredients 2", distance: 4.3,price: 225),
        Food(image: #imageLiteral(resourceName: "burger3"), title: "Burger 3", ingredients: "list of ingredients 3", distance: 6.7,price: 687)*/
    ]
    let db = Firestore.firestore()
    let imageStore = Storage.storage()
    override func viewDidLoad() {
        db.collection("Foods").getDocuments { (snapshot, error) in
            
            if(error != nil){
                print(error as Any)
            }
            let locationService = LocationService()
            locationService.onLocationRecived = {location in
                self.currentLocation = location
                self.loadData(snapshot: snapshot, currentLocation: location)
            }
            locationService.requestLocation()
        }
        super.viewDidLoad()

    // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func loadData(snapshot:QuerySnapshot?,currentLocation:CLLocation?) {
        for doc in snapshot?.documents ?? []{
            var food = Food()
            let data = doc.data()
            let foodLocation = data["location"] as! GeoPoint
            food.location = CLLocation(latitude: foodLocation.latitude, longitude: foodLocation.longitude)
            food.distance = round(Float(currentLocation?.distance(from:
                food.location!) ?? 0 as Double) / 1000 * 100)/100
            food.ingredients = data["ingredients"] as? String
            food.price = data["price"] as! Int
            food.title = data["title"] as? String
            
         //   food.image = #imageLiteral(resourceName: "burger1")
            
            self.data.append(food)
            let index = self.data.count - 1
            self.tableView.reloadData()
            imageStore.reference(withPath: "\(doc.documentID).jpg").getData(maxSize: 1 * 1024 * 1024) { data, err in
                if(err != nil){
                    print(err)
                }
                self.data[index].image = UIImage(data: data!)
                self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
            }
            
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count == 0 ? 2 : data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! CustomTableViewCell
        if(data.count > 0){
            transverse(view: cell.contentView, mode: false,exceptionView: cell.foodPicture)
            if(data[indexPath.row].image != nil){
                cell.foodPicture.hideSkeleton()
                cell.foodPicture.image = data[indexPath.row].image
            }
            
        cell.foodTitle.text = data[indexPath.row].title
        cell.ingredients.text = data[indexPath.row].ingredients
        cell.price.text = "LKR. \(data[indexPath.row].price)"
        cell.distance.text = "\(data[indexPath.row].distance == 0 ? "Provide permission":String(data[indexPath.row].distance)) KM"
        cell.expandBtn.tag = indexPath.row
        }else{
            cell.ingredients.numberOfLines = 1
            transverse(view: cell.contentView, mode: true)
            cell.mainView.showSkeleton()
            
        }
        // Configure the cell...

        return cell
    }
    func transverse(view:UIView,mode:Bool,exceptionView:UIView? = nil){
        if(view is UIButton || view is UILabel || view is UIImageView){
            view.isSkeletonable = true
            if(mode){
                view.showAnimatedGradientSkeleton()
            }else if(view != exceptionView){
                view.hideSkeleton()
            }
            
            
        }
        else{
            for child in view.subviews{
                transverse(view: child,mode:mode,exceptionView: exceptionView
                )
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
