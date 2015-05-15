//
//  Utils.swift
//  EarthQuakeFeed
//
//  Created by Aldo R Bonilla Guerrero on 14/05/15.
//  Copyright (c) 2015 Aldo R Bonilla Guerrero. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    class func stringFromDate(var date: NSDate, format: String) -> String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.stringFromDate(date)
    }

    class func addBorderToView(view: UIView, width: CGFloat, radius: CGFloat, color: CGColorRef) {
        view.layer.cornerRadius = radius
        view.layer.borderColor = color
        view.layer.borderWidth = width
    }
}

extension NSDate {
    
    class func datePlusDays(date: NSDate, days: Int) -> NSDate {
        var timeInt = NSTimeInterval(days * 24 * 60 * 60)
        return date.dateByAddingTimeInterval(timeInt)
    }
}