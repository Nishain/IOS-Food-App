//
//  Food.swift
//  Food App
//
//  Created by Nishain on 2/11/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
struct Food {
    var image:UIImage?
    var title:String?
    var ingredients:String?
    var distance:Float = 0.0
    var price:Int = 0
    var location:CLLocation?
}
struct FoodDetails{
    var image:UIImage?
    var title:String?
    var ingredients:String?
    var price:Int = 0
}
