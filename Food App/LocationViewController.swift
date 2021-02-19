//
//  ViewController.swift
//  Food App
//
//  Created by Nishain on 2/7/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import UIKit
import CoreLocation
class LocationViewController: UIViewController{
    
    let locationManager:LocationService = .init()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onRequestPermission(_ sender: UIButton) {
        locationManager.onUserPermissionChanged = {() in
            //rootNavigator
            let screen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "rootNavigator")
            self.present(screen,animated:true,completion: nil)
        }
        locationManager.requestWhenInUseAuthorization()
        
    }
    
}


