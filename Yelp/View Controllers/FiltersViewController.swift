//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Ding, Quan on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

private let sectionHeaders = [["name": "Sort", "code": "sort"],
    ["name": "Radius", "code": "radius_filter"],
    ["name": "Has Deals", "code": "deals_filter"],
    ["name": "Categories", "code": "category_filter"]]

private let sortingOptions = [["name": "Best Match", "code": "0"],
    ["name": "Distance", "code": "1"],
    ["name": "Highest Rated", "code": "2"]]

private let radiusOptions = [["name": "0.3 mile", "code": "483"],
    ["name": "1 mile", "code": "1609"],
    ["name": "5 miles", "code": "8047"],
    ["name": "20 miles", "code": "32187"]]

private let dealOptions = [["name": "Has Deals", "code": "true"]]

private let categoryOptions: [Dictionary<String, String>] =
[["name" : "Afghan", "code": "afghani"],
    ["name" : "African", "code": "african"],
    ["name" : "American, New", "code": "newamerican"],
    ["name" : "American, Traditional", "code": "tradamerican"],
    ["name" : "Arabian", "code": "arabian"],
    ["name" : "Argentine", "code": "argentine"],
    ["name" : "Armenian", "code": "armenian"],
    ["name" : "Asian Fusion", "code": "asianfusion"],
    ["name" : "Asturian", "code": "asturian"],
    ["name" : "Australian", "code": "australian"],
    ["name" : "Austrian", "code": "austrian"],
    ["name" : "Baguettes", "code": "baguettes"],
    ["name" : "Bangladeshi", "code": "bangladeshi"],
    ["name" : "Barbeque", "code": "bbq"],
    ["name" : "Basque", "code": "basque"],
    ["name" : "Bavarian", "code": "bavarian"],
    ["name" : "Beer Garden", "code": "beergarden"],
    ["name" : "Beer Hall", "code": "beerhall"],
    ["name" : "Beisl", "code": "beisl"],
    ["name" : "Belgian", "code": "belgian"],
    ["name" : "Bistros", "code": "bistros"],
    ["name" : "Black Sea", "code": "blacksea"],
    ["name" : "Brasseries", "code": "brasseries"],
    ["name" : "Brazilian", "code": "brazilian"],
    ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
    ["name" : "British", "code": "british"],
    ["name" : "Buffets", "code": "buffets"],
    ["name" : "Bulgarian", "code": "bulgarian"],
    ["name" : "Burgers", "code": "burgers"],
    ["name" : "Burmese", "code": "burmese"],
    ["name" : "Cafes", "code": "cafes"],
    ["name" : "Cafeteria", "code": "cafeteria"],
    ["name" : "Cajun/Creole", "code": "cajun"],
    ["name" : "Cambodian", "code": "cambodian"],
    ["name" : "Canadian", "code": "New)"],
    ["name" : "Canteen", "code": "canteen"],
    ["name" : "Caribbean", "code": "caribbean"],
    ["name" : "Catalan", "code": "catalan"],
    ["name" : "Chech", "code": "chech"],
    ["name" : "Cheesesteaks", "code": "cheesesteaks"],
    ["name" : "Chicken Shop", "code": "chickenshop"],
    ["name" : "Chicken Wings", "code": "chicken_wings"],
    ["name" : "Chilean", "code": "chilean"],
    ["name" : "Chinese", "code": "chinese"],
    ["name" : "Comfort Food", "code": "comfortfood"],
    ["name" : "Corsican", "code": "corsican"],
    ["name" : "Creperies", "code": "creperies"],
    ["name" : "Cuban", "code": "cuban"],
    ["name" : "Curry Sausage", "code": "currysausage"],
    ["name" : "Cypriot", "code": "cypriot"],
    ["name" : "Czech", "code": "czech"],
    ["name" : "Czech/Slovakian", "code": "czechslovakian"],
    ["name" : "Danish", "code": "danish"],
    ["name" : "Delis", "code": "delis"],
    ["name" : "Diners", "code": "diners"],
    ["name" : "Dumplings", "code": "dumplings"],
    ["name" : "Eastern European", "code": "eastern_european"],
    ["name" : "Ethiopian", "code": "ethiopian"],
    ["name" : "Fast Food", "code": "hotdogs"],
    ["name" : "Filipino", "code": "filipino"],
    ["name" : "Fish & Chips", "code": "fishnchips"],
    ["name" : "Fondue", "code": "fondue"],
    ["name" : "Food Court", "code": "food_court"],
    ["name" : "Food Stands", "code": "foodstands"],
    ["name" : "French", "code": "french"],
    ["name" : "French Southwest", "code": "sud_ouest"],
    ["name" : "Galician", "code": "galician"],
    ["name" : "Gastropubs", "code": "gastropubs"],
    ["name" : "Georgian", "code": "georgian"],
    ["name" : "German", "code": "german"],
    ["name" : "Giblets", "code": "giblets"],
    ["name" : "Gluten-Free", "code": "gluten_free"],
    ["name" : "Greek", "code": "greek"],
    ["name" : "Halal", "code": "halal"],
    ["name" : "Hawaiian", "code": "hawaiian"],
    ["name" : "Heuriger", "code": "heuriger"],
    ["name" : "Himalayan/Nepalese", "code": "himalayan"],
    ["name" : "Hong Kong Style Cafe", "code": "hkcafe"],
    ["name" : "Hot Dogs", "code": "hotdog"],
    ["name" : "Hot Pot", "code": "hotpot"],
    ["name" : "Hungarian", "code": "hungarian"],
    ["name" : "Iberian", "code": "iberian"],
    ["name" : "Indian", "code": "indpak"],
    ["name" : "Indonesian", "code": "indonesian"],
    ["name" : "International", "code": "international"],
    ["name" : "Irish", "code": "irish"],
    ["name" : "Island Pub", "code": "island_pub"],
    ["name" : "Israeli", "code": "israeli"],
    ["name" : "Italian", "code": "italian"],
    ["name" : "Japanese", "code": "japanese"],
    ["name" : "Jewish", "code": "jewish"],
    ["name" : "Kebab", "code": "kebab"],
    ["name" : "Korean", "code": "korean"],
    ["name" : "Kosher", "code": "kosher"],
    ["name" : "Kurdish", "code": "kurdish"],
    ["name" : "Laos", "code": "laos"],
    ["name" : "Laotian", "code": "laotian"],
    ["name" : "Latin American", "code": "latin"],
    ["name" : "Live/Raw Food", "code": "raw_food"],
    ["name" : "Lyonnais", "code": "lyonnais"],
    ["name" : "Malaysian", "code": "malaysian"],
    ["name" : "Meatballs", "code": "meatballs"],
    ["name" : "Mediterranean", "code": "mediterranean"],
    ["name" : "Mexican", "code": "mexican"],
    ["name" : "Middle Eastern", "code": "mideastern"],
    ["name" : "Milk Bars", "code": "milkbars"],
    ["name" : "Modern Australian", "code": "modern_australian"],
    ["name" : "Modern European", "code": "modern_european"],
    ["name" : "Mongolian", "code": "mongolian"],
    ["name" : "Moroccan", "code": "moroccan"],
    ["name" : "New Zealand", "code": "newzealand"],
    ["name" : "Night Food", "code": "nightfood"],
    ["name" : "Norcinerie", "code": "norcinerie"],
    ["name" : "Open Sandwiches", "code": "opensandwiches"],
    ["name" : "Oriental", "code": "oriental"],
    ["name" : "Pakistani", "code": "pakistani"],
    ["name" : "Parent Cafes", "code": "eltern_cafes"],
    ["name" : "Parma", "code": "parma"],
    ["name" : "Persian/Iranian", "code": "persian"],
    ["name" : "Peruvian", "code": "peruvian"],
    ["name" : "Pita", "code": "pita"],
    ["name" : "Pizza", "code": "pizza"],
    ["name" : "Polish", "code": "polish"],
    ["name" : "Portuguese", "code": "portuguese"],
    ["name" : "Potatoes", "code": "potatoes"],
    ["name" : "Poutineries", "code": "poutineries"],
    ["name" : "Pub Food", "code": "pubfood"],
    ["name" : "Rice", "code": "riceshop"],
    ["name" : "Romanian", "code": "romanian"],
    ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
    ["name" : "Rumanian", "code": "rumanian"],
    ["name" : "Russian", "code": "russian"],
    ["name" : "Salad", "code": "salad"],
    ["name" : "Sandwiches", "code": "sandwiches"],
    ["name" : "Scandinavian", "code": "scandinavian"],
    ["name" : "Scottish", "code": "scottish"],
    ["name" : "Seafood", "code": "seafood"],
    ["name" : "Serbo Croatian", "code": "serbocroatian"],
    ["name" : "Signature Cuisine", "code": "signature_cuisine"],
    ["name" : "Singaporean", "code": "singaporean"],
    ["name" : "Slovakian", "code": "slovakian"],
    ["name" : "Soul Food", "code": "soulfood"],
    ["name" : "Soup", "code": "soup"],
    ["name" : "Southern", "code": "southern"],
    ["name" : "Spanish", "code": "spanish"],
    ["name" : "Steakhouses", "code": "steak"],
    ["name" : "Sushi Bars", "code": "sushi"],
    ["name" : "Swabian", "code": "swabian"],
    ["name" : "Swedish", "code": "swedish"],
    ["name" : "Swiss Food", "code": "swissfood"],
    ["name" : "Tabernas", "code": "tabernas"],
    ["name" : "Taiwanese", "code": "taiwanese"],
    ["name" : "Tapas Bars", "code": "tapas"],
    ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
    ["name" : "Tex-Mex", "code": "tex-mex"],
    ["name" : "Thai", "code": "thai"],
    ["name" : "Traditional Norwegian", "code": "norwegian"],
    ["name" : "Traditional Swedish", "code": "traditional_swedish"],
    ["name" : "Trattorie", "code": "trattorie"],
    ["name" : "Turkish", "code": "turkish"],
    ["name" : "Ukrainian", "code": "ukrainian"],
    ["name" : "Uzbek", "code": "uzbek"],
    ["name" : "Vegan", "code": "vegan"],
    ["name" : "Vegetarian", "code": "vegetarian"],
    ["name" : "Venison", "code": "venison"],
    ["name" : "Vietnamese", "code": "vietnamese"],
    ["name" : "Wok", "code": "wok"],
    ["name" : "Wraps", "code": "wraps"],
    ["name" : "Yugoslav", "code": "yugoslav"]];

private let switchOptions = [sortingOptions, radiusOptions, dealOptions, categoryOptions]

protocol FiltersViewControllerDelegate : class {
    func didChangeFilters(filtersViewcontroller:FiltersViewController, filters:NSDictionary)
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersTableViewCellDelegate {
    
    weak var delegate:FiltersViewControllerDelegate?
    var filters:NSDictionary! // the filters dictionary passed to ListViewController
    var expandedSections:NSMutableIndexSet!
    var switchSelections:[NSMutableSet]!
    
    @IBOutlet weak var filtersTable: UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        filters = NSDictionary()
        expandedSections = NSMutableIndexSet() as NSMutableIndexSet
        
        switchSelections = [NSMutableSet(), NSMutableSet(), NSMutableSet(), NSMutableSet()]
    }
    
    @IBAction func onSearch(sender: AnyObject) {
        print("onSearch")
        
        self.dismissViewControllerAnimated(true, completion: nil)
        self.filters = getFilterSelections()
        delegate?.didChangeFilters(self, filters: self.filters)
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        print("onCancel")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.filtersTable.sectionHeaderHeight = 40
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaders[section]["name"]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionHeaders.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < 2 && !expandedSections.containsIndex(section) {
            return 1 // only show top row
        }
        else {
            return switchOptions[section].count
        }
    }
    
    private func fadeInLabel(label: UILabel) -> Void {
        label.alpha = 0
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            label.alpha = 1.0
            }, completion: nil)
    }
    
    private func fadeOutLabel(label: UILabel) -> Void {
        label.alpha = 1
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            label.alpha = 0
            }, completion: nil)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableViewCanCollapseSection(indexPath.section) {
            if indexPath.row == 0 {
                self.filtersTable.deselectRowAtIndexPath(indexPath, animated: true)
                let currentlyExpanded:Bool = expandedSections.containsIndex(indexPath.section)
                let section = indexPath.section
                var rows: Int
                var tmpArray:[NSIndexPath] = [NSIndexPath]()
                if currentlyExpanded {
                    rows = self.tableView(self.filtersTable, numberOfRowsInSection: section)
                    expandedSections.removeIndex(indexPath.section)
                }
                else {
                    expandedSections.addIndex(indexPath.section)
                    rows = self.tableView(self.filtersTable, numberOfRowsInSection: section)
                }
                var tmpIndexPath:NSIndexPath
                for (var i = 1; i < rows; i++) {
                    tmpIndexPath = NSIndexPath(forRow: i, inSection: section)
                    tmpArray.append(tmpIndexPath)
                }
                
                let cell = self.filtersTable.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: section))
                let selectionName = getSelectionNameInSection(section)
                let firstRowInSectionName = switchOptions[section][0]["name"]
                let label = (cell as! CheckerTableViewCell).settingsLabel
                if currentlyExpanded {
                    self.filtersTable.deleteRowsAtIndexPaths(tmpArray, withRowAnimation: UITableViewRowAnimation.Top)
                    if selectionName != nil{
                        label.text = selectionName
                        fadeInLabel(label)
                    }
                }
                else {
                    self.filtersTable.insertRowsAtIndexPaths(tmpArray, withRowAnimation: UITableViewRowAnimation.Top)
                    label.text = firstRowInSectionName
                    fadeInLabel(label)
                }

                if (label.text == selectionName){
                    ((cell as! CheckerTableViewCell).settingsSwitch as! UIButton).setImage(UIImage(named: "tick"), forState: UIControlState.Normal)
                }
                else {
                    ((cell as! CheckerTableViewCell).settingsSwitch as! UIButton).setImage(UIImage(named: "white"), forState: UIControlState.Normal)
                }
            }
        }
        
    }
    
    private func getSelectionNameInSection (section: Int) -> String? {
        var name:String?
        for selection in self.switchSelections[section] {
            name = selection["name"] as? String
            print("tableViewCellForRowAtIndexPath: \(name)")
        }
        return name
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        if indexPath.section >= 2 {
            cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! FiltersTableViewCell
            (cell as! FiltersTableViewCell).delegate = self
            ((cell as! FiltersTableViewCell).settingsSwitch as! UISwitch).on = self.switchSelections[indexPath.section].containsObject(switchOptions[indexPath.section][indexPath.row])
            (cell as! FiltersTableViewCell).settingsLabel.text = switchOptions[indexPath.section][indexPath.row]["name"]
        }
        else {
            cell = tableView.dequeueReusableCellWithIdentifier("CheckerCell", forIndexPath: indexPath) as! CheckerTableViewCell
            (cell as! CheckerTableViewCell).delegate = self
            ((cell as! CheckerTableViewCell).settingsSwitch as! UIButton).setImage(UIImage(named: "tick"), forState: UIControlState.Normal)
//            ((cell as CheckerTableViewCell).settingsSwitch as UIButton).setImage(UIImage(named: "white"), forState: UIControlState.Highlighted | UIControlState.Selected | UIControlState.Application)

            let name = getSelectionNameInSection(indexPath.section)
            let label:UILabel = (cell as! CheckerTableViewCell).settingsLabel
            label.text = ""
            fadeOutLabel(label)
            
            if !expandedSections.containsIndex(indexPath.section) && self.switchSelections[indexPath.section].count > 0 {
                label.text = name
                fadeInLabel(label)
            }
            else {
                let labelText = switchOptions[indexPath.section][indexPath.row]["name"]
                label.text = labelText
                fadeInLabel(label)
                if (labelText != name) {
                    ((cell as! CheckerTableViewCell).settingsSwitch as! UIButton).setImage(UIImage(named: "white"), forState: UIControlState.Normal)
                }
            }
        }

//        cell.layer.cornerRadius = 5
//        cell.layer.masksToBounds = true
//        cell.layer.borderWidth = 1
//        cell.clipsToBounds = true

        
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
        
        return cell
    }
    
    func tableViewCanCollapseSection(section: Int) -> Bool {
        if (section < 2) {
            return true
        }
        return false
    }
    
    func filtersView(filtersCell: UITableViewCell, didChangeSwitchValue value:Bool){
        print("FiltersView delegate got the new value: \(value)")
        let indexPath:NSIndexPath = self.filtersTable.indexPathForCell(filtersCell)!
        let selection = switchOptions[indexPath.section][indexPath.row]
        
        print(( value ? "Add" : "Remove" ) + " selection: \(selection)")
        if (value){
            if (indexPath.section != 3){ // not a food category selection
                // need to clean up all previous on selections
                self.switchSelections[indexPath.section].removeAllObjects()
            }
            self.switchSelections[indexPath.section].addObject(selection)
        }
        else {
            self.switchSelections[indexPath.section].removeObject(selection)
        }
        
        collapseSection(indexPath)
        
        let sections = NSMutableIndexSet()
        sections.addIndex(indexPath.section)
        self.filtersTable.reloadSections(sections, withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    func collapseSection(indexPath:NSIndexPath) -> Void {
        if tableViewCanCollapseSection(indexPath.section){
            // find out unselected rows and collapse them
            var tmpArray:[NSIndexPath] = [NSIndexPath]()
            let rows = self.tableView(self.filtersTable, numberOfRowsInSection: indexPath.section)
            var tmpIndexPath:NSIndexPath
            let selectionNames:NSMutableSet = NSMutableSet()
            for selection in self.switchSelections[indexPath.section]{
                let name = (selection as! Dictionary<String, String>)["name"]!
                print("selection name: \(name)")
                selectionNames.addObject(name)
            }
            print("selection names size: \(selectionNames.count)")
            for (var i = 0; i < rows; i++) {
                print(switchOptions[indexPath.section][i]["name"]!)
                if !selectionNames.containsObject(switchOptions[indexPath.section][i]["name"]!) {
                    tmpIndexPath = NSIndexPath(forRow: i, inSection: indexPath.section)
                    tmpArray.append(tmpIndexPath)
                }
            }
            expandedSections.removeIndex(indexPath.section)
            self.filtersTable.deleteRowsAtIndexPaths(tmpArray, withRowAnimation: UITableViewRowAnimation.Top)
            
        }
    }
    
    func getFilterSelections() -> NSDictionary {
        let filters = NSMutableDictionary()

        // process the sorting option
        if self.switchSelections[0].count > 0 {
            for selection in self.switchSelections[0] {
                filters["sort"] = selection["code"] as! String
            }
        }
        // process radius option
        if self.switchSelections[1].count > 0 {
            for selection in self.switchSelections[1] {
                filters["radius_filter"] = selection["code"] as! String
            }
        }
        // process deals option
        if self.switchSelections[2].count > 0 {
            filters["deals_filter"] = "true"
        }
        // process the category options
        if self.switchSelections[3].count > 0 {
            var selectedCategories:[String] = []
            for selection in self.switchSelections[3] {
                selectedCategories.append(selection["code"] as! String)
            }
            filters["category_filter"] = selectedCategories.joinWithSeparator(",")
        }
        return filters;
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
