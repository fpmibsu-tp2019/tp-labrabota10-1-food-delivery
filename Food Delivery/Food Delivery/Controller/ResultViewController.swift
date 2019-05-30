//
//  ResultViewController.swift
//  Food Delivery
//
//  Created by Kirill Zheltovski on 30/05/2019.
//  Copyright © 2019 FoodDeliveryLab10. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = UIImage(named: "Ray")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
