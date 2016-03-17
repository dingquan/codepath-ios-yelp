//
//  BusinessTableViewCell.swift
//  Yelp
//
//  Created by Ding, Quan on 2/10/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbnailImg: UIImageView!
    @IBOutlet weak var ratingsImg: UIImageView!
    
    var business:Business? {
        didSet {
            self.nameLabel.text = self.business?.name
            self.addressLabel.text = self.business?.address
            self.categoryLabel.text = self.business?.categories
            if let numReviews = self.business?.numReviews {
                self.reviewsLabel.text = "\(numReviews) reviews"
            }
            
            if let distance = self.business?.distance {
                self.distanceLabel.text = String(format: "%.2f mi", distance)
            }
            if let thumbnailUrl = self.business?.imageUrl {
                self.thumbnailImg.layer.cornerRadius = 5
                self.thumbnailImg.clipsToBounds = true
//                self.thumbnailImg.setImageWithURL(NSURL(string: thumbnailUrl))
                let urlReq = NSURLRequest(URL: NSURL(string: thumbnailUrl)!)
                self.thumbnailImg.setImageWithURLRequest(urlReq, placeholderImage: UIImage(named: "white"),
                    success: { (request: NSURLRequest!, response: NSHTTPURLResponse!, image:UIImage!) -> Void in
                        self.thumbnailImg.alpha = 0.0
                        self.thumbnailImg.image = image
                        UIView.animateWithDuration(0.25, animations: {self.thumbnailImg.alpha = 1.0 })
                    }, failure: { (request:NSURLRequest!, response:NSHTTPURLResponse!, error:NSError!) -> Void in
                        print(error)
                })

            }
            if let ratingsUrl = self.business?.ratingImageUrl {
                self.ratingsImg.setImageWithURL(NSURL(string: ratingsUrl))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
