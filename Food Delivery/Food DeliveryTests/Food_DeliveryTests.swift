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
}
