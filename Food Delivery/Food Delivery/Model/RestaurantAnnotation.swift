//
//  Restaurant.swift
//  Food Delivery
//
//  Created by Kirill Zheltovski on 30/05/2019.
//  Copyright © 2019 FoodDeliveryLab10. All rights reserved.
//

import Foundation
import MapKit

class RestaurantAnnotation: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = "Minsk"
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
