//
//  EarthqueakeAnnotation.swift
//  EarthQuakeFeed
//
//  Created by Aldo R Bonilla Guerrero on 15/05/15.
//  Copyright (c) 2015 Aldo R Bonilla Guerrero. All rights reserved.
//

import MapKit

class EarthquakeAnnotation: NSObject, MKAnnotation {
    var coordinate :CLLocationCoordinate2D
    var title: String
    var subtitle: String
    var earthquake: Earthquake
    
    init(earthquake: Earthquake)
    {
        self.earthquake = earthquake
        coordinate = CLLocationCoordinate2D(latitude: earthquake.latitude, longitude: earthquake.longitude)
        title = earthquake.title
        subtitle = earthquake.place
    }
}
