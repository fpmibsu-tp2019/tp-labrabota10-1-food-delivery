//
//  Restaurant.swift
//  Food Delivery
//
//  Created by Konstantin Tomashevich on 5/27/19.
//  Copyright © 2019 FoodDeliveryLab10. All rights reserved.
//

import Foundation
import CoreData

class RestaurantRecord {
    private var databaseObject: NSManagedObject?
    
    // Load actual restaurant record from database.
    init(persistentContainer: NSPersistentContainer, id: Int32) {
        let managedContext = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Restaurant")
        request.predicate = NSPredicate(format: "restaurant_id = %d", id)
        let objects = try! managedContext.fetch(request) as! [NSManagedObject]
            
        if objects.count > 0 {
            self.databaseObject = objects[0]
        } else {
            self.databaseObject = nil
        }
    }
    
    // Create new restaurant record in database.
    init(persistentContainer: NSPersistentContainer, title: String, subtitle: String, latitude: Double, longitude: Double) {
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Restaurant", in: managedContext)!
        // TODO: Dirty way.
        let count = try! managedContext.count(for: NSFetchRequest(entityName: "Restaurant"))
        
        databaseObject = NSManagedObject(entity: entity, insertInto: managedContext)
        databaseObject!.setValue(count + 1, forKey: "restaurant_id")
        databaseObject!.setValue(latitude, forKey: "latitude")
        databaseObject!.setValue(longitude, forKey: "longitude")
        databaseObject!.setValue(title, forKey: "title")
        databaseObject!.setValue(subtitle, forKey: "subtitle")
        
        try! managedContext.save()
    }
    
    func delete(persistentContainer: NSPersistentContainer) {
        persistentContainer.viewContext.delete(databaseObject!)
        try! persistentContainer.viewContext.save()
    }
    
    func latitude() -> Double? {
        return databaseObject?.value(forKey: "latitude") as? Double
    }
    
    func longitude() -> Double? {
        return databaseObject?.value(forKey: "longitude") as? Double
    }
    
    func title() -> String? {
        return databaseObject?.value(forKey: "title") as? String
    }
    
    func subtitle() -> String? {
        return databaseObject?.value(forKey: "subtitle") as? String
    }
    
    func id() -> Int32? {
        return databaseObject?.value(forKey: "restaurant_id") as? Int32
    }
}
