//
//  OrderRecord.swift
//  Food Delivery
//
//  Created by Konstantin Tomashevich on 5/28/19.
//  Copyright © 2019 FoodDeliveryLab10. All rights reserved.
//

import Foundation
import CoreData

class OrderRecord {
    private var databaseObject: NSManagedObject?
    
    // Load actual record from database.
    init(persistentContainer: NSPersistentContainer, id: Int32) {
        let managedContext = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
        request.predicate = NSPredicate(format: "order_id = %d", id)
        let objects = try! managedContext.fetch(request) as! [NSManagedObject]
        
        if objects.count > 0 {
            self.databaseObject = objects[0]
        } else {
            self.databaseObject = nil
        }
    }
    
    // Create new record in database.
    init(persistentContainer: NSPersistentContainer, foodType: FoodTypeRecord, paymentType: Int16,
         restaurant: RestaurantRecord) {
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Order", in: managedContext)!
        // TODO: Dirty way.
        let count = try! managedContext.count(for: NSFetchRequest(entityName: "Order"))
        
        databaseObject = NSManagedObject(entity: entity, insertInto: managedContext)
        databaseObject!.setValue(count + 1, forKey: "order_id")
        databaseObject!.setValue(foodType.id()!, forKey: "food_type_id")
        databaseObject!.setValue(paymentType, forKey: "payment_type")
        databaseObject!.setValue(restaurant.id()!, forKey: "restaurant_id")
        databaseObject!.setValue(false, forKey: "accepted")
        
        try! managedContext.save()
    }
    
    func delete(persistentContainer: NSPersistentContainer) {
        persistentContainer.viewContext.delete(databaseObject!)
        try! persistentContainer.viewContext.save()
    }
    
    func id() -> Int32? {
        return databaseObject?.value(forKey: "order_id") as? Int32
    }
    
    func paymentType() -> Int16? {
        return databaseObject?.value(forKey: "payment_type") as? Int16
    }
    
    func accepted() -> Bool? {
        return databaseObject?.value(forKey: "accepted") as? Bool
    }
    
    func accept(persistentContainer: NSPersistentContainer) {
        databaseObject!.setValue(true, forKey: "accepted")
        try! persistentContainer.viewContext.save()
    }
    
    func foodType(persistentContainer: NSPersistentContainer) -> FoodTypeRecord? {
        if databaseObject == nil {
            return nil
        }
        
        let foodId = databaseObject!.value(forKey: "food_type_id") as! Int32
        return FoodTypeRecord(persistentContainer: persistentContainer, id: foodId)
    }
    
    func restaurant(persistentContainer: NSPersistentContainer) -> RestaurantRecord? {
        if databaseObject == nil {
            return nil
        }
        
        let restaurantId = databaseObject!.value(forKey: "restaurant_id") as! Int32
        return RestaurantRecord(persistentContainer: persistentContainer, id: restaurantId)
    }
    
    func options(persistentContainer: NSPersistentContainer) -> [OptionValueRecord] {
        if databaseObject == nil {
            return []
        }
        
        let managedContext = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "OrderOptions")
        request.predicate = NSPredicate(format: "order_id = %d", id()!)
        let objects = try! managedContext.fetch(request) as! [NSManagedObject]
        var records: [OptionValueRecord] = []
        
        for object in objects {
            records.append(OptionValueRecord(persistentContainer: persistentContainer,
                                            id: object.value(forKey: "option_value_id") as! Int32))
        }
        
        return records
    }
    
    func addOption(persistentContainer: NSPersistentContainer, value: OptionValueRecord) {
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "OrderOptions", in: managedContext)!
        
        let connectionObject = NSManagedObject(entity: entity, insertInto: managedContext)
        connectionObject.setValue(id()!, forKey: "order_id")
        connectionObject.setValue(value.id()!, forKey: "option_value_id")
        
        try! managedContext.save()
    }
    
    func removeOption(persistentContainer: NSPersistentContainer, value: OptionValueRecord) {
        let managedContext = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "OrderOptions")
        request.predicate = NSPredicate(format: "option_value_id = %d and order_id = %d", value.id()!, id()!)
        let objects = try! managedContext.fetch(request) as! [NSManagedObject]
        
        for object in objects {
            managedContext.delete(object)
        }
        
        try! managedContext.save()
    }
}
