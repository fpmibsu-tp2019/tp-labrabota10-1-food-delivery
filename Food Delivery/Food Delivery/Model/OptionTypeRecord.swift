//
//  OptionTypeRecord.swift
//  Food Delivery
//
//  Created by Konstantin Tomashevich on 5/27/19.
//  Copyright © 2019 FoodDeliveryLab10. All rights reserved.
//

import Foundation
import CoreData

class OptionTypeRecord {
    private var databaseObject: NSManagedObject?
    
    // Load actual record from database.
    init(persistentContainer: NSPersistentContainer, id: Int32) {
        let managedContext = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "OptionType")
        request.predicate = NSPredicate(format: "option_type_id = %d", id)
        let objects = try! managedContext.fetch(request) as! [NSManagedObject]
        
        if objects.count > 0 {
            self.databaseObject = objects[0]
        } else {
            self.databaseObject = nil
        }
    }
    
    // Create new record in database.
    init(persistentContainer: NSPersistentContainer, name: String) {
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "OptionType", in: managedContext)!
        // TODO: Dirty way.
        let count = try! managedContext.count(for: NSFetchRequest(entityName: "OptionType"))
        
        databaseObject = NSManagedObject(entity: entity, insertInto: managedContext)
        databaseObject!.setValue(count + 1, forKey: "option_type_id")
        databaseObject!.setValue(name, forKey: "option_name")
        
        try! managedContext.save()
    }
    
    func delete(persistentContainer: NSPersistentContainer) {
        persistentContainer.viewContext.delete(databaseObject!)
        try! persistentContainer.viewContext.save()
    }
    
    func id() -> Int32? {
        return databaseObject?.value(forKey: "option_type_id") as? Int32
    }
    
    func name() -> String? {
        return databaseObject?.value(forKey: "option_name") as? String
    }
    
    func optionValues(persistentContainer: NSPersistentContainer) -> [OptionValueRecord] {
        if databaseObject == nil {
            return []
        }
        
        let managedContext = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "OptionValue")
        request.predicate = NSPredicate(format: "option_id = %d", id()!)
        let objects = try! managedContext.fetch(request) as! [NSManagedObject]
        var records: [OptionValueRecord] = []
        
        for object in objects {
            records.append(OptionValueRecord(persistentContainer: persistentContainer,
                                             id: object.value(forKey: "option_value_id") as! Int32))
        }
        
        return records
    }
}
