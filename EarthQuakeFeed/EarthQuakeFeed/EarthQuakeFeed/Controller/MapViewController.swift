//
//  MapViewController.swift
//  EarthQuakeFeed
//
//  Created by Aldo R Bonilla Guerrero on 15/05/15.
//  Copyright (c) 2015 Aldo R Bonilla Guerrero. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var eartquakes = [Earthquake]()
    var eqSelected: Earthquake?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let btnListView = UIBarButtonItem(title: "List", style: UIBarButtonItemStyle.Plain, target: self, action: "openList")
        let btnRefresh = UIBarButtonItem(title: "Refresh", style: UIBarButtonItemStyle.Plain, target: self, action: "refresh")
        self.navigationItem.rightBarButtonItems = [btnListView, btnRefresh]
        refresh()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openList() {
        performSegueWithIdentifier("listView", sender: nil)
    }
    
    func openAboutMe() {
        performSegueWithIdentifier("aboutMe", sender: nil)
    }
    
    func refresUI() {
        mapView.removeAnnotations(mapView.annotations)
        addAnnotations()
    }
    
    func addAnnotations() {
        for earthquake in eartquakes {
            let eqAnnotation = EarthquakeAnnotation(earthquake: earthquake)
            mapView.addAnnotation(eqAnnotation)
        }
    }
    
    func refresh() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        LibraryAPI.sharedInstance.getEartquakesByTime(onSuccess:{(
            eartquakes) in
            self.eartquakes = eartquakes
            NSOperationQueue.mainQueue().addOperationWithBlock({
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                self.refresUI()
            })
            }, onError: {(error) in
                let alert = UIAlertController(
                    title: "Invalid Login",
                    message: "Incorrect Username and/or Password",
                    preferredStyle: UIAlertControllerStyle.Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in }
                alert.addAction(OKAction)
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    self.presentViewController(alert, animated: true, completion: nil)
                })
        })
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annID")
        let eqAnnotation = annotation as! EarthquakeAnnotation
        switch eqAnnotation.earthquake.pinColor {
        case 0:
            annotationView.pinColor = MKPinAnnotationColor.Green
        case 1:
            annotationView.pinColor = MKPinAnnotationColor.Purple
        case 2:
            annotationView.pinColor = MKPinAnnotationColor.Red
        default:
            annotationView.pinColor = MKPinAnnotationColor.Red
        }
        
        return annotationView
    }
    
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        performSegueWithIdentifier("detail", sender: view.annotation as? EarthquakeAnnotation)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detail" {
            let detailVC = segue.destinationViewController as! EarthquakeDetailViewController
            let eqAnnotation = sender as! EarthquakeAnnotation
            detailVC.earthquake = eqAnnotation.earthquake
        }
    }
}
