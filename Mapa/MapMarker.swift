//
//  MapMarker.swift
//  Mapa
//
//  Created by Kamil on 25/10/2017.
//  Copyright © 2017 Użytkownik Gość. All rights reserved.
//

import UIKit
import MapKit

class MapMarker: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
        
}
