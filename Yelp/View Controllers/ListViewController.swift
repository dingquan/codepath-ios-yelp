//
//  ViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, MKMapViewDelegate, FiltersViewControllerDelegate {
    var client: YelpClient!
    var businesses: [Business]!
    var searchTerm: String!
    var filters:NSDictionary?
    
    @IBOutlet var businessMap: MKMapView!
    @IBOutlet weak var listMapToggle: UIBarButtonItem!
    @IBOutlet var businessTable: UITableView!
    
    @IBOutlet weak var containerView: UIView!
    
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    let yelpConsumerKey = "MQK-oWjydcXp04cLfFo15w"
    let yelpConsumerSecret = "GajRCetLvpF_GN8Ctl7oo_4bXcE"
    let yelpToken = "YMx-5O3SU7CYzlHVL8CsiYAxJw56vFz7"
    let yelpTokenSecret = "lyLY6vjfok_RfCkJ4c7lSDmqJB8"
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.searchTerm = "food"
    }
    
    @IBAction func toggleMap(sender: AnyObject) {
        if self.listMapToggle.title == "Map"{
            
//            self.businessMap.hidden = true
//            self.containerView.addSubview(self.businessMap)
//            // install constraints
//            
//            self.containerView.addConstraints(
//                [
//                    NSLayoutConstraint(item: self.businessMap, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.containerView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0),
//                    NSLayoutConstraint(item: self.businessMap, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.containerView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0),
//                    NSLayoutConstraint(item: self.businessMap, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.containerView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0),
//                    NSLayoutConstraint(item: self.businessMap, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.containerView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
//                    
//                ])
            
            self.listMapToggle.title = "List"
            UIView.transitionFromView(self.businessTable, toView: self.businessMap, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromLeft | UIViewAnimationOptions.ShowHideTransitionViews, completion: { (animationFlag:Bool) -> Void in
                
                //self.businessTable.removeFromSuperview()
                
            })
        }
        else {
            
//            self.businessTable.hidden = true
//            self.containerView.addSubview(self.businessTable)
//            // add constraints back
//            
//            self.containerView.addConstraints(
//                [
//                    NSLayoutConstraint(item: self.businessTable, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.containerView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0),
//                    NSLayoutConstraint(item: self.businessTable, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.containerView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0),
//                    NSLayoutConstraint(item: self.businessTable, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.containerView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0),
//                    NSLayoutConstraint(item: self.businessTable, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.containerView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
//                    
//                ])
            
            self.listMapToggle.title = "Map"
            
            
            UIView.transitionFromView(self.businessMap, toView: self.businessTable, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromLeft | UIViewAnimationOptions.ShowHideTransitionViews, completion: { (animationFlag:Bool) -> Void in
                
                //self.businessMap.removeFromSuperview()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //        self.businessTable.delegate = self
        //        self.businessTable.dataSource = self
        
        var searchBar:UISearchBar = UISearchBar()
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        
        //        self.businessMap.hidden = true
        initializeMap()
        
        self.businessTable.estimatedRowHeight = 102
        
        self.businessTable.rowHeight = UITableViewAutomaticDimension
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        searchBusinesses(self.searchTerm, params: self.filters)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.businesses?.count {
            return count
        }
        else {
            return 0
        }
    }
    
    func initializeMap() -> Void {
        var lat:CLLocationDegrees = 37.791412
        var long:CLLocationDegrees = -122.395606
        var span:MKCoordinateSpan = MKCoordinateSpanMake(CLLocationDegrees(0.02), CLLocationDegrees(0.02))
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)

        self.businessMap.setRegion(region, animated: false)
    }
    
    func loadBusinessesOnMap() -> Void {
        var annotations:[MKPointAnnotation] = [MKPointAnnotation]()
        if self.businesses != nil {
            for business in self.businesses {
                var businessLat = business.latitude!
                var businessLong = business.longitude!
                var businessLocation = CLLocationCoordinate2DMake(CLLocationDegrees(businessLat), CLLocationDegrees(businessLong))
                var annotation = MKPointAnnotation()
                annotation.coordinate = businessLocation
                annotation.title = business.name
                annotation.subtitle = "\(business.numReviews!) reviews"
                annotations.append(annotation)
            }
        }
        self.businessMap.addAnnotations(annotations)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as BusinessTableViewCell
        
        // change the default margin of the table divider length
        if (cell.respondsToSelector(Selector("setPreservesSuperviewLayoutMargins:"))){
            cell.preservesSuperviewLayoutMargins = false
        }
        
        if (cell.respondsToSelector(Selector("setSeparatorInset:"))){
            cell.separatorInset = UIEdgeInsetsMake(0, 4, 0, 0)
        }
        
        if (cell.respondsToSelector(Selector("setLayoutMargins:"))){
            cell.layoutMargins = UIEdgeInsetsZero
        }
        
        cell.business = self.businesses[indexPath.row]
        return cell
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        var searchText:String = searchBar.text
        if searchText.isEmpty{
            return
        }
        println("searching for " + searchText)
        searchBar.resignFirstResponder()
        self.searchTerm = searchText
        searchBusinesses(searchText, params: self.filters)
    }
    
    func searchBusinesses(searchTerm:String, params:NSDictionary?){
        client.searchWithTerm(searchTerm, params: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println(response["businesses"])
            self.businesses = Business.businessesWithDictionaries(response["businesses"] as NSArray)
            self.businessTable.reloadData()
            self.loadBusinessesOnMap()
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        })
    }
    
    func didChangeFilters(filtersViewcontroller:FiltersViewController, filters:NSDictionary){
        println("Filter has changed: \(filters)")
        self.filters = filters
        searchBusinesses(self.searchTerm, params: filters)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showFilters" {
            if let filtersViewController = segue.destinationViewController as? FiltersViewController{
                filtersViewController.delegate = self
            }
        }
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if (annotation is MKUserLocation) {
            //if annotation is not an MKPointAnnotation (eg. MKUserLocation),
            //return nil so map draws default view for it (eg. blue dot)...
            return nil
        }
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if pinView == nil {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView.image = UIImage(named:"pin")
            pinView.canShowCallout = true
        }
        else {
            //we are re-using a view, update its annotation reference...
            pinView.annotation = annotation
        }
        
        return pinView
    }
}

