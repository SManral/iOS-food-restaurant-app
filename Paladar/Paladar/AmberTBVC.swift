//
//  File.swift
//  Paladar
//
//  Created by Julio Salinas on 11/2/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import Foundation
import UIKit

class AmberTBVC: UITableViewController, UISearchResultsUpdating {
    
    var Pilsner = ["Alfa Edel Pils","Bavaria Pilsner","Becks","Bitburger","Brooklyn Pilsner","Czech Rebel","Grolsch Premium Pilsner","Hirter Pivat Pils","König Pilsner","Lagunita Pils","Mahr's Pilsner", "New Belgium Blue Paddle","Palma Louca","Pilsner Urquell","Pinkus Pills","Radeberger Pilsner","Saint Arnold Summer Pils","Sierra Nevada Summerfest","Sly Fox Pils","Spaten Pils","Stoudts's Pils","Summit Pilsner","Twin Lakes Route 52 Pilsner","Victory Prima Pils","Vltins Pilsner","Würzburger Pilsner"]
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
        self.filteredBeers = self.Pilsner.filter {(Pilsner:String) -> Bool in
            if Pilsner.lowercaseString.containsString(self.searchControler.searchBar.text!.lowercaseString){
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
            return self.Pilsner.count
        }else
        {
            return self.filteredBeers.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
        
    {
        let cell = UITableViewCell()
        
        if tableView == self.tableView{
            cell.textLabel?.text = self.Pilsner[indexPath.row]
        }else{
            cell.textLabel?.text = self.filteredBeers[indexPath.row]
        }
        
        return cell
        
    }
    
    
}