//
//  Food_DeliveryTests.swift
//  Food DeliveryTests
//
//  Created by Konstantin Tomashevich on 5/25/19.
//  Copyright © 2019 FoodDeliveryLab10. All rights reserved.
//

import XCTest
@testable import Food_Delivery
import CoreData

class Food_DeliveryTests: XCTestCase {
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Food_Delivery")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
   
    func testNaiveRestaurantRecord () {
        let title = "Title"
        let subtitle = "Subtitle"
        let latitude = 12.3
        let longitude = 45.6
        
        let firstRecord = RestaurantRecord(persistentContainer: persistentContainer,
                                           title: title, subtitle: subtitle,
                                           latitude: latitude, longitude: longitude)
        
        XCTAssert(title == firstRecord.title())
        XCTAssert(subtitle == firstRecord.subtitle())
        XCTAssert(latitude == firstRecord.latitude())
        XCTAssert(longitude == firstRecord.longitude())
        
        let secondRecord = RestaurantRecord(persistentContainer: persistentContainer, id: firstRecord.id()!)
        XCTAssert(secondRecord.title() == firstRecord.title())
        XCTAssert(secondRecord.subtitle() == firstRecord.subtitle())
        XCTAssert(secondRecord.latitude() == firstRecord.latitude())
        XCTAssert(secondRecord.longitude() == firstRecord.longitude())
    }
    
    func testNaiveOptionTypeAndValueRecords() {
        let optionName = "OptionName"
        let optionValue1Name = "OptionValue1"
        let optionValue2Name = "OptionValue2"
        
        let optionValue1CostDelta = 0.1
        let optionValue2CostDelta = 0.2
        
        let createdOptionType = OptionTypeRecord(persistentContainer: persistentContainer, name: optionName)
        XCTAssert(optionName == createdOptionType.name())
        let fetchedOptionType = OptionTypeRecord(persistentContainer: persistentContainer, id: createdOptionType.id()!)
        XCTAssert(fetchedOptionType.name() == createdOptionType.name())
        
        let createdOptionValue1 = OptionValueRecord(persistentContainer: persistentContainer, name: optionValue1Name, optionType: fetchedOptionType, costDelta: optionValue1CostDelta)
        XCTAssert(optionValue1Name == createdOptionValue1.name())
        XCTAssert(optionValue1CostDelta == createdOptionValue1.costDelta())
        
        let fetchedOptionValue1 = OptionValueRecord(persistentContainer: persistentContainer, id: createdOptionValue1.id()!)
        XCTAssert(fetchedOptionValue1.name() == createdOptionValue1.name())
        XCTAssert(fetchedOptionValue1.costDelta() == createdOptionValue1.costDelta())
        
        let createdOptionValue2 = OptionValueRecord(persistentContainer: persistentContainer, name: optionValue2Name, optionType: fetchedOptionType, costDelta: optionValue2CostDelta)
        XCTAssert(optionValue2Name == createdOptionValue2.name())
        XCTAssert(optionValue2CostDelta == createdOptionValue2.costDelta())
        
        let fetchedOptionValue2 = OptionValueRecord(persistentContainer: persistentContainer, id: createdOptionValue2.id()!)
        XCTAssert(fetchedOptionValue2.name() == createdOptionValue2.name())
        XCTAssert(fetchedOptionValue2.costDelta() == createdOptionValue2.costDelta())
        
        XCTAssert(fetchedOptionValue1.optionType(persistentContainer: persistentContainer)!.name () == optionName)
        XCTAssert(fetchedOptionValue2.optionType(persistentContainer: persistentContainer)!.name () == optionName)
        
        let optionValues = fetchedOptionType.optionValues(persistentContainer: persistentContainer)
        XCTAssert(optionValues[0].name() == fetchedOptionValue1.name())
        XCTAssert(optionValues[0].costDelta() == fetchedOptionValue1.costDelta())
        
        XCTAssert(optionValues[1].name() == fetchedOptionValue2.name())
        XCTAssert(optionValues[1].costDelta() == fetchedOptionValue2.costDelta())
    }
}
