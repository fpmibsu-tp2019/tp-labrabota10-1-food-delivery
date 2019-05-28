//
//  OptionValue.swift
//  Food Delivery
//
//  Created by Konstantin Tomashevich on 5/27/19.
//  Copyright © 2019 FoodDeliveryLab10. All rights reserved.
//

import Foundation
import CoreData

class OptionValueRecord {
    private var databaseObject: NSManagedObject?
    
    // Load actual record from database.
    init(persistentContainer: NSPersistentContainer, id: Int32) {
        let managedContext = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "OptionValue")
        request.predicate = NSPredicate(format: "option_value_id = %d", id)
        let objects = try! managedContext.fetch(request) as! [NSManagedObject]
        
        if objects.count > 0 {
            self.databaseObject = objects[0]
        } else {
            self.databaseObject = nil
        }
    }
    
    // Create new record in database.
    init(persistentContainer: NSPersistentContainer, name: String, optionType: OptionTypeRecord, costDelta: Double) {
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "OptionValue", in: managedContext)!
        // TODO: Dirty way.
        let count = try! managedContext.count(for: NSFetchRequest(entityName: "OptionValue"))
        
        databaseObject = NSManagedObject(entity: entity, insertInto: managedContext)
        databaseObject!.setValue(count + 1, forKey: "option_value_id")
        databaseObject!.setValue(name, forKey: "name")
        databaseObject!.setValue(costDelta, forKey: "cost_delta")
        databaseObject!.setValue(optionType.id(), forKey: "option_id")
        
        try! managedContext.save()
    }
    
    func delete(persistentContainer: NSPersistentContainer) {
        persistentContainer.viewContext.delete(databaseObject!)
        try! persistentContainer.viewContext.save()
    }
    
    func id() -> Int32? {
        return databaseObject?.value(forKey: "option_value_id") as? Int32
    }
    
    func name() -> String? {
        return databaseObject?.value(forKey: "name") as? String
    }
    
    func costDelta() -> Double? {
        return databaseObject?.value(forKey: "cost_delta") as? Double
    }
    
    func optionType(persistentContainer: NSPersistentContainer) -> OptionTypeRecord? {
        if databaseObject == nil {
            return nil
        }
        
        return OptionTypeRecord(persistentContainer: persistentContainer,
                                id: databaseObject!.value(forKey: "option_id") as! Int32)
    }
}
