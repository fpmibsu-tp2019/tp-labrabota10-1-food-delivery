//
//  MapViewController.swift
//  Food Delivery
//
//  Created by Kirill Zheltovski on 30/05/2019.
//  Copyright © 2019 FoodDeliveryLab10. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var location = CLLocation()
    
    let regionRadius: CLLocationDistance = 20000
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mapView.delegate = self
        
        // getLocation();
        location = CLLocation(latitude: 53.893009, longitude: 27.567)
        
        centerMapOnLocation(location: location)
        
        mapView.addAnnotation(RestaurantAnnotation(title: "Kamyanitsa", coordinate: CLLocationCoordinate2D(latitude: 53.944, longitude: 27.5122)))
        
        mapView.addAnnotation(RestaurantAnnotation(title: "Stirlitz spy bar", coordinate: CLLocationCoordinate2D(latitude: 53.946, longitude: 27.5927)))
        
        mapView.addAnnotation(RestaurantAnnotation(title: "Chekhov", coordinate: CLLocationCoordinate2D(latitude: 53.926, longitude: 27.645)))
        
        mapView.addAnnotation(RestaurantAnnotation(title: "Belaruskaya Karchma", coordinate: CLLocationCoordinate2D(latitude: 53.899, longitude: 27.648)))
        
        mapView.addAnnotation(RestaurantAnnotation(title: "KFC", coordinate: CLLocationCoordinate2D(latitude: 53.873, longitude: 27.637)))
        
        mapView.addAnnotation(RestaurantAnnotation(title: "Baldenini", coordinate: CLLocationCoordinate2D(latitude: 53.8704, longitude: 27.580)))
        
        mapView.addAnnotation(RestaurantAnnotation(title: "Staromestniy pivovar", coordinate: CLLocationCoordinate2D(latitude: 53.865, longitude: 27.5322)))
        
        mapView.addAnnotation(RestaurantAnnotation(title: "McDonalds", coordinate: CLLocationCoordinate2D(latitude: 53.878, longitude: 27.495)))
        
        mapView.addAnnotation(RestaurantAnnotation(title: "Burger King", coordinate: CLLocationCoordinate2D(latitude: 53.908, longitude: 27.475)))
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.performSegue(withIdentifier: "showResult", sender: view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
