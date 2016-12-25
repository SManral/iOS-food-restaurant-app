//
//  WheatBeersTBVC.swift
//  Paladar
//
//  Created by Julio Salinas on 10/20/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import Foundation
import UIKit

class WheatBeersTBVC: UITableViewController, UISearchResultsUpdating {
    
    var wheatBeers = ["422 Pale Wheat Ale","Anchor Summer","Allagash White","Bell's Oberon","Berlinder Kindl Weiss","Blue Moon","Boulevard Unfiltered Wheat Beer","Brooklyn Weiss","Crack'd Wheat","Dundee Wheat Beer","Flying Dog In-heat Wheat", "Hacker-Pschorr Dunkle Weiss","Lake Front Wheat Monkey","Magic Hat Circus Boy","New Belgium Mothership Wit","Ommegang Witte","Otter Summer","Redhook Sunrye Summer Ale","Saint Arnold Texas Wheat","Samuel Adams Summer Ale","Shock Top Belgian White","Sierra Nevada Kellerweis","Terrapin SunRay Wheat Beer","Widmer Hefeweizen"]
    var searchControler : UISearchController!
    var resultController = UITableViewController()
    var filteredBeers = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resultController.tableView.dataSource = self
        self.resultController.tableView.delegate = self
        //PaleLagersBeers =
        
        self.searchControler = UISearchController(searchResultsController: self.resultController)
        
        self.tableView.tableHeaderView = self.searchControler.searchBar
        
        self.searchControler.searchResultsUpdater = self
        
        self.searchControler.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        //filter through the beers
        self.filteredBeers = self.wheatBeers.filter {(wheatBeers:String) -> Bool in
            if wheatBeers.lowercaseString.containsString(self.searchControler.searchBar.text!.lowercaseString){
                return true
            }else{
                return false
            }
        }
        
        //Update the results in tableview
        self.resultController.tableView.reloadData()
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == self.tableView{
            return self.wheatBeers.count
        }else
        {
            return self.filteredBeers.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
        
    {
        let cell = UITableViewCell()
        
        if tableView == self.tableView{
            cell.textLabel?.text = self.wheatBeers[indexPath.row]
        }else{
            cell.textLabel?.text = self.filteredBeers[indexPath.row]
        }
        
        return cell
        
}

}
