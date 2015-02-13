//
//  ViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FiltersViewControllerDelegate {
    var client: YelpClient!
    var businesses: [Business]!
    
    @IBOutlet weak var businessTable: UITableView!

    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    let yelpConsumerKey = "MQK-oWjydcXp04cLfFo15w"
    let yelpConsumerSecret = "GajRCetLvpF_GN8Ctl7oo_4bXcE"
    let yelpToken = "YMx-5O3SU7CYzlHVL8CsiYAxJw56vFz7"
    let yelpTokenSecret = "lyLY6vjfok_RfCkJ4c7lSDmqJB8"
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        self.businessTable.delegate = self
//        self.businessTable.dataSource = self
        
        var searchBar:UISearchBar = UISearchBar()
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        
        self.businessTable.estimatedRowHeight = 102
        
        self.businessTable.rowHeight = UITableViewAutomaticDimension
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        searchBusinesses("Chinese Restaurant")
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
        println("searching for " + searchBar.text)
        searchBar.resignFirstResponder()
        searchBusinesses(searchBar.text)
    }
    
    func searchBusinesses(searchTerm:String){
        client.searchWithTerm(searchTerm, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println(response["businesses"])
            self.businesses = Business.businessesWithDictionaries(response["businesses"] as NSArray)
            self.businessTable.reloadData()
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        })
    }
    
    func didChangeFilters(filtersViewcontroller:FiltersViewController, filters:Dictionary<String, AnyObject>){
        println("Filter has changed")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showFilters" {
            if let filtersViewController = segue.destinationViewController as? FiltersViewController{
                filtersViewController.delegate = self
            }
        }
    }
}

