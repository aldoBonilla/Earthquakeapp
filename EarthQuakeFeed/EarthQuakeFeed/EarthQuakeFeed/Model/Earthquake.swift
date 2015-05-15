//
//  Earthquake.swift
//  EarthQuakeFeed
//
//  Created by Aldo R Bonilla Guerrero on 14/05/15.
//  Copyright (c) 2015 Aldo R Bonilla Guerrero. All rights reserved.
//

import UIKit

class Earthquake: NSObject {
    var detailURL: String
    var latitude: Double
    var longitude: Double
    var magnitud: Float
    var place: String
    var time: NSDate
    var title: String
    var tsunami: Bool
    var typeQ: String
    var url: String
    
    init(dictionaryWS: Dictionary <String, AnyObject>) {
        detailURL = dictionaryWS["detail"] as! String
        magnitud = dictionaryWS["mag"] as! Float
        latitude = dictionaryWS["latitude"] as! Double
        longitude = dictionaryWS["longitude"] as! Double
        place = dictionaryWS["place"] as! String
        var timeInterval = dictionaryWS["time"] as! NSTimeInterval
        timeInterval = timeInterval * 0.001
        time = NSDate(timeIntervalSince1970: timeInterval)
        title = dictionaryWS["title"] as! String
        tsunami = dictionaryWS["tsunami"] as! Bool
        typeQ = dictionaryWS["type"] as! String
        url = dictionaryWS["url"] as! String
    }
    
    var colorForEarthquakeMagnitud: UIColor {
        if magnitud >= 0 && magnitud < 1 {
            return UIColor(red: 0.48, green: 0.73, blue: 0.32, alpha: 1.0)
        } else if magnitud >= 1 && magnitud < 2 {
            return UIColor(red: 0.57, green: 0.76, blue: 0.31, alpha: 1.0)
        } else if magnitud >= 2 && magnitud < 3 {
            return UIColor(red: 0.77, green: 0.84, blue: 0.26, alpha: 1.0)
        } else if magnitud >= 3 && magnitud < 4 {
            return UIColor(red: 0.97, green: 0.90, blue: 0.28, alpha: 1.0)
        } else if magnitud >= 4 && magnitud < 5 {
            return UIColor(red: 0.95, green: 0.83, blue: 0.20, alpha: 1.0)
        } else if magnitud >= 5 && magnitud < 6 {
            return UIColor(red: 0.92, green: 0.72, blue: 0.26, alpha: 1.0)
        } else if magnitud >= 6 && magnitud < 7 {
            return UIColor.yellowColor()
        } else if magnitud >= 7 && magnitud < 8 {
            return UIColor(red: 0.89, green: 0.59, blue: 0.21, alpha: 1.0)
        } else if magnitud >= 8 && magnitud < 9 {
            return UIColor(red: 0.85, green: 0.46, blue: 0.24, alpha: 1.0)
        } else if magnitud >= 9 && magnitud < 10 {
            return UIColor(red: 0.82, green: 0.25, blue: 0.26, alpha: 1.0)
        } else {
            return UIColor.blackColor()
        }
        
    }
    
    var pinColor: Int {
        if magnitud >= 0 && magnitud < 3 {
            return 1
        } else if magnitud >= 3 && magnitud < 7 {
            return 2
        }
        return 0
    }
}