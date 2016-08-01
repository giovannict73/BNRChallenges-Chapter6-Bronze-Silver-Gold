//
//  WorldAnnotation.swift
//  WorldTrotter
//
//  Created by Giovanni Catania on 24/04/16.
//  Copyright © 2016 Giovanni Catania. All rights reserved.
//

import MapKit
import UIKit

class WorldAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.info = info
    }
}