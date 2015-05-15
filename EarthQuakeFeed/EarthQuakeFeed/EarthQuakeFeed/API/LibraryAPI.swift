//
//  LibraryAPI.swift
//  EarthQuakeFeed
//
//  Created by Aldo R Bonilla Guerrero on 14/05/15.
//  Copyright (c) 2015 Aldo R Bonilla Guerrero. All rights reserved.
//

import Foundation

class LibraryAPI {
    
    class var sharedInstance: LibraryAPI {
        struct Singleton {
            static let instance = LibraryAPI()
        }
        return Singleton.instance
    }
    
    func getEartquakesByTime(#onSuccess:([Earthquake]) -> Void, onError: (NSError) -> Void) {
        let httpClient = HTTPClient()
        let stringInitDate = Utils.stringFromDate(NSDate.datePlusDays(NSDate(), days: -1), format: "yyyy-MM-dd")
        let stringEndDate = Utils.stringFromDate(NSDate(), format: "yyyy-MM-dd")
        httpClient.doRequest("geojson&starttime=\(stringInitDate)&endtime=\(stringEndDate)",
            onSuccess: {(data) in
                var earthquakes = [Earthquake]()
                let features = data["features"] as! [Dictionary <String, AnyObject>]
                for feature in features {
                    var properties = feature["properties"] as! Dictionary <String, AnyObject>
                    let geometry = feature["geometry"] as! Dictionary <String, AnyObject>
                    let coordinates = geometry["coordinates"] as! [Double]
                    properties.updateValue (coordinates[0], forKey: "longitude")
                    properties.updateValue (coordinates[1], forKey: "latitude")
                    earthquakes.append(Earthquake(dictionaryWS: properties))
                }
                onSuccess(earthquakes)
            },
            onError: {(error) in
                onError(error)
            }
        )
    }
}