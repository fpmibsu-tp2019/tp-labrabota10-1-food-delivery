//
//  FoodViewController.swift
//  Food Delivery
//
//  Created by Kirill Zheltovski on 30/05/2019.
//  Copyright © 2019 FoodDeliveryLab10. All rights reserved.
//

import UIKit

class FoodViewController : UICollectionViewController {
    
    private let foodData = FoodData()
    private var foodImages: [UIImage] = []
    
    var selectedIndexPath: IndexPath? {
        didSet {
            print("\(selectedIndexPath)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for foodName in foodData.foodNames {
            foodImages.append(UIImage(named: foodName)!)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodData.pListData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FoodViewCell
        
        let row = indexPath.row
        let foodName = foodData.foodNames[row]
        
        cell.label.text = foodData.foodNames[indexPath.row] + "\n" + (foodData.pListData[foodName] as! Array)[0]!
        cell.image.image = foodImages[indexPath.row]
        
        return cell
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMoreInfo" {
            let c = segue.destination as! OrderViewController
            
            let row = selectedIndexPath!.row
            
            let facultyName = foodData.foodNames[row]
            
            /*c.image = facultyImages[row]
            c.name = facultyName
            c.date = (facultyData.pListData[facultyName] as! Array)[0]!
            c.desc = (facultyData.pListData[facultyName] as! Array)[1]!*/
        }
    }*/
}
/*
extension FoodViewController {
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if selectedIndexPath == indexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        
        self.performSegue(withIdentifier: "showMoreInfo", sender: self)
        
        return false
    }
}*/
