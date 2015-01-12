//
//  MainViewController.swift
//  WYD
//
//  Created by Fan Ye on 1/9/15.
//  Copyright (c) 2015 WYD. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    var firstLocationUpdate: Bool?
    let locationManager = CLLocationManager()
    
    @IBAction func userIconTapped(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startMaps()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startMaps() {
        
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()

        
        if self.locationManager.location != nil {
            let location: CLLocation = self.locationManager.location
            var target: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            var camera: GMSCameraPosition = GMSCameraPosition(target: target, zoom: 10, bearing: 0, viewingAngle: 0)
            
            self.mapView.myLocationEnabled = true
            self.mapView.settings.myLocationButton = true
            self.mapView.camera = camera
            self.mapView.delegate = self
            
            var marker = GMSMarker()
            marker.position = location.coordinate
            marker.map = mapView
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        NSLog(error.description)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
