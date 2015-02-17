//
//  Business.swift
//  Yelp
//
//  Created by Ding, Quan on 2/9/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import Foundation

class Business {
    var imageUrl:String?
    var name:String?
    var ratingImageUrl:String?
    var numReviews:Int?
    var address:String?
    var categories:String?
    var distance:Float?
    var latitude:Float?
    var longitude:Float?
    
    init(){
        
    }
    
    class func businessWithDictionary(dictionary:NSDictionary) -> Business {
        var business:Business = Business()
        business.name = dictionary["name"] as? String
        business.imageUrl = dictionary["image_url"] as? String
        business.ratingImageUrl = dictionary["rating_img_url"] as? String
        business.numReviews = dictionary["review_count"] as? NSInteger
        var categoryArr = [String]()
        var tmpCatArr = dictionary["categories"] as! NSArray
        for aCategory in dictionary["categories"] as! NSArray{
            categoryArr.append(aCategory[0] as! String)
        }
        business.categories = ", ".join(categoryArr)
        var location = dictionary["location"] as! NSDictionary
//        var street = (location["address"] as NSArray)[0] as NSString
//        var neighborhood = (location["neighborhoods"] as NSArray)[0] as NSString
//        business.address = "\(street), \(neighborhood)"
        business.address = (location["display_address"] as! NSArray)[0] as! String
        var coordinates = location["coordinate"] as! NSDictionary
        business.latitude = (coordinates["latitude"] as! NSNumber).floatValue
        business.longitude = (coordinates["longitude"] as! NSNumber).floatValue
        business.distance = (dictionary["distance"] as! NSNumber).floatValue * 0.000621371
        return business
    }
    
    class func businessesWithDictionaries(dictionaries:NSArray) -> [Business]{
        var businesses = [Business]()
        for dictionary in dictionaries {
            var business = Business.businessWithDictionary(dictionary as! NSDictionary)
            businesses.append(business)
        }
        return businesses
    }
}
