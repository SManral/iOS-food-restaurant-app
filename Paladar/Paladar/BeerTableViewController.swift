//
//  BeerTableViewController.swift
//  Paladar
//
//  Created by Julio Salinas on 10/19/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//


import Foundation
import UIKit

class BeerTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var PaleLagersBeers = ["Amstel Light","Asahi","Birra Moretti","Bud Light","Budweiser","Coors Light","Corona Extra","DAB Dortmunder","Dos Equis Special Lager","Foster's Lager","Grain Belt Premium", "Harp Lager","Heineken","Kirin Ichiban","Labatt Blue","Land Shark Lager","Leinenkugel's","Michelob","Miller Lite","Molson","Peroni","Red Stripe","Rolling Rock","Samuel Adams Boston Lager","Sapporo","Stella Artois","Victory Lager","Yuengling Lager"]
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
        self.filteredBeers = self.PaleLagersBeers.filter {(PaleLagersBeers:String) -> Bool in
            if PaleLagersBeers.lowercaseString.containsString(self.searchControler.searchBar.text!.lowercaseString){
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
        return self.PaleLagersBeers.count
        }else
        {
         return self.filteredBeers.count
       }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
        
    {
        let cell = UITableViewCell()
        
        if tableView == self.tableView{
           cell.textLabel?.text = self.PaleLagersBeers[indexPath.row]
        }else{
            cell.textLabel?.text = self.filteredBeers[indexPath.row]
        }
        
        return cell
        
    }
     

}
