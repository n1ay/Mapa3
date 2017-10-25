//
//  ViewController.swift
//  Mapa
//
//  Created by Użytkownik Gość on 24.10.2017.
//  Copyright © 2017 Użytkownik Gość. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var clearAllButton: UIButton!

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.isEnabled = false
        centerMapOnUserLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onStartPress(_ sender: UIButton) {
        startButton.isEnabled = false
        stopButton.isEnabled = true
    }
    @IBAction func onStopPress(_ sender: UIButton) {
        startButton.isEnabled = true
        stopButton.isEnabled = false
    }
    @IBAction func onClearAllPress(_ sender: UIButton) {
        
    }
    
    func centerMapOnUserLocation() {
        print("update")
        var speed: CLLocationSpeed = (locationManager.location?.speed)!
        if speed < 0 {
            speed = 0
        }
        let regionRadius: CLLocationDistance = CLLocationDistance((450*speed)+500)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(mapView.userLocation.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
        let when = DispatchTime.now() + 5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.centerMapOnUserLocation()
        }
    }
    
    
    
}

