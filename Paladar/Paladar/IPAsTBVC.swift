//
//  IPAsTBVC.swift
//  Paladar
//
//  Created by Julio Salinas on 10/20/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import Foundation
import UIKit

class IPAsTBVC: UITableViewController, UISearchResultsUpdating {
    
    var ipa = ["21st Amendment Brew Free! or Die IPA","Acme IPA","Ale Smith IPA","Avery IPA","Back Yark IPA","Brooklyn East IPA","Commodore Perry IPA","Dogfish Head 60 Minute IPA","Dogfish Head 90 Minute IPA","Full Sail IPA","Fullers India Pale Ale","Goose Island India Pale Ale","Harpoon IPA","Hop Hearty Ale","Hoptical Illusion","Inversion IPA","Lagunitas IPA","Sierra Nevada Torpedo","Shipyard IPA","Summit India Pale Ale","West Coast IPA","Victory Hop Devil","Wolaver's India Pale Ale","Yards India Pale Ale"]
    var searchControler : UISearchController!
    var resultController = UITableViewController()
    var filteredBeers = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resultController.tableView.dataSource = self
        self.resultController.tableView.delegate = self
        
        
        self.searchControler = UISearchController(searchResultsController: self.resultController)
        
        self.tableView.tableHeaderView = self.searchControler.searchBar
        
        self.searchControler.searchResultsUpdater = self
        
        self.searchControler.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        //filter through the beers
        self.filteredBeers = self.ipa.filter {(ipa:String) -> Bool in
            if ipa.lowercaseString.containsString(self.searchControler.searchBar.text!.lowercaseString){
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
            return self.ipa.count
        }else
        {
            return self.filteredBeers.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
        
    {
        let cell = UITableViewCell()
        
        if tableView == self.tableView{
            cell.textLabel?.text = self.ipa[indexPath.row]
        }else{
            cell.textLabel?.text = self.filteredBeers[indexPath.row]
        }
        
        return cell
        
 }
}
