//
//  CategoryTableViewCell.swift
//  Yelp
//
//  Created by Ding, Quan on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

protocol FiltersTableViewCellDelegate : class {
    func filtersView(filtersCell: FiltersTableViewCell, didChangeSwitchValue value:Bool)
}

class FiltersTableViewCell: UITableViewCell {
    weak var delegate: FiltersTableViewCellDelegate?
    
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var settingsSwitch: UISwitch!
    
    @IBAction func switchValueChanged(sender: AnyObject) {
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
