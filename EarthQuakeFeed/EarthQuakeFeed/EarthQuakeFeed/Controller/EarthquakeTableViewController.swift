//
//  EarthquakeTableViewController.swift
//  EarthQuakeFeed
//
//  Created by Aldo R Bonilla Guerrero on 14/05/15.
//  Copyright (c) 2015 Aldo R Bonilla Guerrero. All rights reserved.
//

import UIKit

class EarthquakeTableViewController: UITableViewController {
    
    var eartquakes = [Earthquake]()
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl!.backgroundColor = UIColor.greenColor()
        refreshControl!.tintColor = UIColor.whiteColor()
        refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl!.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl!)
        let btnMapView = UIBarButtonItem(title: "Map", style: UIBarButtonItemStyle.Plain, target: self, action: "openMap")
        let btnRefresh = UIBarButtonItem(title: "Refresh", style: UIBarButtonItemStyle.Plain, target: self, action: "refresh")
        self.navigationItem.rightBarButtonItems = [btnMapView, btnRefresh]
        refresh()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func openMap() {
        performSegueWithIdentifier("mapView", sender: nil)
    }
    
    func openAboutMe() {
        performSegueWithIdentifier("aboutMe", sender: nil)
    }
    
    //MARK: - Table view data source

    func refresh() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        LibraryAPI.sharedInstance.getEartquakesByTime(onSuccess:{(
            eartquakes) in
            self.eartquakes = eartquakes
            NSOperationQueue.mainQueue().addOperationWithBlock({
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                self.tableView.reloadData()
                self.refreshControl!.endRefreshing()
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
                    self.refreshControl!.endRefreshing()
                    self.presentViewController(alert, animated: true, completion: nil)
                })
        })
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eartquakes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("earthquakeCell", forIndexPath: indexPath) as! UITableViewCell
        let earthquake = eartquakes[indexPath.row]
        cell.textLabel?.text = earthquake.place
        cell.detailTextLabel?.text = "\(earthquake.magnitud)"
        cell.accessoryView = UIView(frame: CGRectMake(0, 0, 20, 20))
        cell.accessoryView!.backgroundColor = earthquake.colorForEarthquakeMagnitud
        Utils.addBorderToView(cell.accessoryView!, width: 1, radius: 10, color: UIColor.whiteColor().CGColor)
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detail" {
            let detailVC = segue.destinationViewController as! EarthquakeDetailViewController
            detailVC.earthquake = eartquakes[tableView.indexPathForSelectedRow()!.row]
        } 
    }

}
