//
//  EarthqueakeDetailViewController.swift
//  EarthQuakeFeed
//
//  Created by Aldo R Bonilla Guerrero on 15/05/15.
//  Copyright (c) 2015 Aldo R Bonilla Guerrero. All rights reserved.
//

import UIKit
import MapKit

class EarthquakeDetailViewController: UIViewController, MKMapViewDelegate {

    var earthquake: Earthquake?
    
    @IBOutlet weak var lblPlace: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblMagnitud: UILabel!
    @IBOutlet weak var lblTsunami: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
        lblPlace.text = "Place: \(earthquake!.place)"
        lblMagnitud.text = "Magnitude: \(earthquake!.magnitud)"
        lblTsunami.alpha = earthquake!.tsunami == true ? 1.0 : 0.0
        let stringTime = Utils.stringFromDate(earthquake!.time, format: "mm/dd/YYYY")
        lblTime.text = "Time: \(stringTime)"
        // Do any additional setup after loading the view.
    }
    
    func configureMapView() {
        var centerCoordinate = CLLocationCoordinate2DMake(earthquake!.latitude, earthquake!.longitude)
        let adjustedRegion = mapView.regionThatFits(MKCoordinateRegionMakeWithDistance(centerCoordinate, 10000, 10000))
        mapView.setRegion(adjustedRegion, animated: true)
        mapView.showsUserLocation = false
        mapView.addAnnotation(EarthquakeAnnotation(earthquake: earthquake!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    

    @IBAction func openBrowser(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: earthquake!.url)!)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
