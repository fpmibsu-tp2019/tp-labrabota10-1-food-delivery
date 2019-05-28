//
//  FoodTypeRecord.swift
//  Food Delivery
//
//  Created by Konstantin Tomashevich on 5/28/19.
//  Copyright © 2019 FoodDeliveryLab10. All rights reserved.
//

import Foundation
import CoreData

class FoodTypeRecord {
    private var databaseObject: NSManagedObject?
    
    // Load actual restaurant record from database.
    init(persistentContainer: NSPersistentContainer, id: Int32) {
        let managedContext = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodType")
        request.predicate = NSPredicate(format: "food_type_id = %d", id)
        let objects = try! managedContext.fetch(request) as! [NSManagedObject]
        
        if objects.count > 0 {
            self.databaseObject = objects[0]
        } else {
            self.databaseObject = nil
        }
    }
    
    // Create new restaurant record in database.
    init(persistentContainer: NSPersistentContainer, name: String, imageName: String, basicCost: Double) {
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FoodType", in: managedContext)!
        // TODO: Dirty way.
        let count = try! managedContext.count(for: NSFetchRequest(entityName: "FoodType"))
        
        databaseObject = NSManagedObject(entity: entity, insertInto: managedContext)
        databaseObject!.setValue(count + 1, forKey: "food_type_id")
        databaseObject!.setValue(name, forKey: "name")
        databaseObject!.setValue(imageName, forKey: "image_name")
        databaseObject!.setValue(basicCost, forKey: "basic_cost")
        
        try! managedContext.save()
    }
    
    func delete(persistentContainer: NSPersistentContainer) {
        persistentContainer.viewContext.delete(databaseObject!)
        try! persistentContainer.viewContext.save()
    }
    
    func id() -> Int32? {
        return databaseObject?.value(forKey: "food_type_id") as? Int32
    }
    
    func name() -> String? {
        return databaseObject?.value(forKey: "name") as? String
    }
    
    func imageName() -> String? {
        return databaseObject?.value(forKey: "image_name") as? String
    }
    
    func basicCost() -> Double? {
        return databaseObject?.value(forKey: "basic_cost") as? Double
    }
    
    func optionTypes(persistentContainer: NSPersistentContainer) -> [OptionTypeRecord] {
        if databaseObject == nil {
            return []
        }
        
        let managedContext = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodTypeOptions")
        request.predicate = NSPredicate(format: "food_type_id = %d", id()!)
        let objects = try! managedContext.fetch(request) as! [NSManagedObject]
        var records: [OptionTypeRecord] = []
        
        for object in objects {
            records.append(OptionTypeRecord(persistentContainer: persistentContainer,
                                             id: object.value(forKey: "option_id") as! Int32))
        }
        
        return records
    }
    
    func addOptionType(persistentContainer: NSPersistentContainer, type: OptionTypeRecord) {
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FoodTypeOptions", in: managedContext)!
        
        databaseObject = NSManagedObject(entity: entity, insertInto: managedContext)
        databaseObject!.setValue(id()!, forKey: "food_type_id")
        databaseObject!.setValue(type.id()!, forKey: "option_id")
        
        try! managedContext.save()
    }
    
    func removeOptionType(persistentContainer: NSPersistentContainer, type: OptionTypeRecord) {
        let managedContext = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodTypeOptions")
        request.predicate = NSPredicate(format: "option_id = %d and food_type_id = %d", type.id()!, id()!)
        let objects = try! managedContext.fetch(request) as! [NSManagedObject]
        
        for object in objects {
            managedContext.delete(object)
        }
        
        try! managedContext.save()
    }
}
