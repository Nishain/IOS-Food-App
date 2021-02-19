//
//  DetailsViewController.swift
//  Food App
//
//  Created by Nishain on 2/12/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import UIKit
import MapKit
class DetailsViewController: UIViewController,MKMapViewDelegate {
    public var food:Food? = nil
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodTitle: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    public var userCurrentLocation:CLLocationCoordinate2D?
    override func viewDidLoad() {
        super.viewDidLoad()
        print(food?.title as Any)
        foodImage.image = food?.image
        foodTitle.text = food?.title
        ingredients.text = food?.ingredients
        cost.text = "LKR \(food!.price)"
        distance.text = "\(food!.distance) Km"
        
        mapView.delegate = self
        if(food != nil){
            let locationAnotation = MKPointAnnotation()
            locationAnotation.coordinate = food!.location!.coordinate
            mapView.addAnnotation(locationAnotation)
            mapView.camera.centerCoordinate = food!.location!.coordinate
            mapView.camera.centerCoordinateDistance = 600
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
