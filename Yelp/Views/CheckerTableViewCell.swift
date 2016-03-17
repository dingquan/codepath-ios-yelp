//
//  CheckerTableViewCell.swift
//  Yelp
//
//  Created by Ding, Quan on 2/13/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class CheckerTableViewCell: UITableViewCell, YelpTableViewCell {

    weak var delegate: FiltersTableViewCellDelegate?
    
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var settingsSwitch: UIControl!

    
    @IBAction func switchValueChanged(sender: AnyObject) {
        print("switch for label \"\(settingsLabel.text!)\" has changed to true")
        delegate?.filtersView(self, didChangeSwitchValue: true)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
