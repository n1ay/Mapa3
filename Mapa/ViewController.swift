//
//  ViewController.swift
//  Mapa
//
//  Created by Użytkownik Gość on 24.10.2017.
//  Copyright © 2017 Użytkownik Gość. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var clearAllButton: UIButton!
    
    let locationManager: CLLocationManager = CLLocationManager()
    var paused: Bool = true
    var isRunning: Bool = false
    var markers: [MapMarker] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.isEnabled = false
        mapView.delegate = self
        mapView.showsScale = true
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onStartPress(_ sender: UIButton) {
        startButton.isEnabled = false
        stopButton.isEnabled = true
        locationManager.startUpdatingLocation()
        paused = false
        mapView.showsUserLocation = true
        if(isRunning) {
            return
        }
        isRunning = true
        onUpdate()
    }
    @IBAction func onStopPress(_ sender: UIButton) {
        startButton.isEnabled = true
        stopButton.isEnabled = false
        locationManager.stopUpdatingLocation()
        paused = true
        mapView.showsUserLocation = false
    }
    @IBAction func onClearAllPress(_ sender: UIButton) {
        mapView.removeAnnotations(markers)
        markers.removeAll()
    }
    
    func onUpdate() {
        if paused {
            isRunning = false
            return
        }
        if let location = locationManager.location {
            if let speed = location.speed as? CLLocationSpeed {
                let regionRadius: CLLocationDistance = CLLocationDistance((25*speed)+150)
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,                                                                  regionRadius, regionRadius)
                addressLabel.text = "\(location.coordinate.latitude), \(location.coordinate.longitude)"
                mapView.setRegion(coordinateRegion, animated: true)
                let marker = MapMarker(coordinate: location.coordinate)
                mapView.addAnnotation(marker)
                markers.append(marker)
                
            }
            
            let when = DispatchTime.now() + 5
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.onUpdate()
            }
        }
    }
    
    
    
}

