//
//  FoodData.swift
//  Food Delivery
//
//  Created by dima on 5/30/19.
//  Copyright © 2019 FoodDeliveryLab10. All rights reserved.
//

import Foundation

class FoodData {
    
    public var pListData: [String: AnyObject] = [:]
    public var foodNames: [String] = []
    
    public init() {
        var propertyListFormat = PropertyListSerialization.PropertyListFormat.xml;
        let pListPath: String? = Bundle.main.path(forResource: "Food", ofType: "plist")!
        let pListXML = FileManager.default.contents(atPath: pListPath!)!
        
        do {
            pListData = try PropertyListSerialization.propertyList(from: pListXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:AnyObject]
            
            foodNames = Array(pListData.keys)
        } catch {
            print("Error reading plist: \(error), format: \(propertyListFormat)")
        }
    }
}
