//
//  CategoryTableViewCell.swift
//  Yelp
//
//  Created by Ding, Quan on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

protocol FiltersTableViewCellDelegate : class {
    func filtersView(filtersCell: UITableViewCell, didChangeSwitchValue value:Bool)
}

protocol YelpTableViewCell {
    var settingsLabel: UILabel! {get}
    var settingsSwitch: UIControl! {get}
    var delegate: FiltersTableViewCellDelegate? {get set}
    
}

class FiltersTableViewCell: UITableViewCell, YelpTableViewCell{
    weak var delegate: FiltersTableViewCellDelegate?
    
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var settingsSwitch: UIControl!
    
    @IBAction func switchValueChanged(sender: AnyObject) {
        let settingsSwitch = self.settingsSwitch as! UISwitch
        println("switch for label \"\(settingsLabel.text!)\" has changed to \(settingsSwitch.on)")
        delegate?.filtersView(self, didChangeSwitchValue: settingsSwitch.on)
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
