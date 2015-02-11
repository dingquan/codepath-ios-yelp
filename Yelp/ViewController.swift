//
//  ViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
        self.businessTable.rowHeight = UITableViewAutomaticDimension
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm("Thai", success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                println(response["businesses"])
                self.businesses = Business.businessesWithDictionaries(response["businesses"] as NSArray)
                println(self.businesses.count)
                self.businessTable.reloadData()
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        })
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
        cell.business = self.businesses[indexPath.row]
        return cell
    }
}

