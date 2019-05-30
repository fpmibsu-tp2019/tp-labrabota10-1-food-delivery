//
//  OrderViewController.swift
//  Food Delivery
//
//  Created by Kirill Zheltovski on 30/05/2019.
//  Copyright © 2019 FoodDeliveryLab10. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {
    
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var donenessSegmentedControl: UISegmentedControl!
    @IBOutlet weak var sauceSegmentedControl: UISegmentedControl!
    
    private let doneness = [ "Rare", "Medium", "Well Done" ]
    private let sauces = [ "Salsa Verde", "Chimichurri", "Teriyaki" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segueChooseRestaurant(_ sender: Any) {
        let quantity = Int(quantityTextField.text!)
        
        let donenessText = doneness[donenessSegmentedControl.selectedSegmentIndex]
        
        let sauceText = sauces[sauceSegmentedControl.selectedSegmentIndex]
        
        print("\(quantity)")
        print("\(donenessText)")
        print("\(sauceText)")
    }
    
}
