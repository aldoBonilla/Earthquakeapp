//
//  HTTPClient.swift
//  EarthQuakeFeed
//
//  Created by Aldo R Bonilla Guerrero on 14/05/15.
//  Copyright (c) 2015 Aldo R Bonilla Guerrero. All rights reserved.
//

import Foundation

class HTTPClient: NSObject {
    
    private let SERVER = "http://earthquake.usgs.gov/fdsnws/event/1/query?format="
    
    private let session: NSURLSession
    private let config: NSURLSessionConfiguration
    private var request: NSMutableURLRequest?
    
    override init() {
        config = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: config)
        session.delegate
    }
    
    func doRequest(query: String, onSuccess: (Dictionary<String, AnyObject>!) -> Void, onError: (NSError) -> Void) {
        prepareRequestWithMethod(query)
        var task = NSURLSessionDataTask()
        task = session.dataTaskWithRequest(request!, completionHandler: {(data, response, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
            if error != nil {
                onError(error)
                return
            }
            var httpResponse :NSHTTPURLResponse = response as! NSHTTPURLResponse
            if (httpResponse.statusCode != 200) {
                println("Received HTTP StatusCode: \(httpResponse.statusCode)")
                onError(NSError(domain: "Unexpected", code: httpResponse.statusCode, userInfo: [:]))
                return
            }
            
            var jsonError :NSError?
            var responseObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments, error: &jsonError)
            
            if jsonError != nil {
                onError(jsonError!)
                return
            }
            var responseDictionary: Dictionary<String, AnyObject>
            if responseObject == nil {
                responseDictionary = [:]
            }
            else {
                responseDictionary = responseObject as! Dictionary<String, AnyObject>
            }
            println("RESPONSE DICTIONARY: \(responseDictionary)")
            onSuccess(responseDictionary)
        })
        task.resume()
    }
    
    func prepareRequestWithMethod(query: String)
    {
        let url = NSURL(string: "\(SERVER)\(query)")!
        request = NSMutableURLRequest(URL: url)
        request!.timeoutInterval = 300
    }
}