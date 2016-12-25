//
//  goldeAlesTBVC.swift
//  Paladar
//
//  Created by Julio Salinas on 10/20/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//
import Foundation
import UIKit

class goldenAlesTBVC: UITableViewController, UISearchResultsUpdating {
    
    var goldenAles = ["Au Naturale","Beach Bum Blonde Ale","Bear Republic Blonde Ale","Big Wave Golden Ale","Carolina Blonde","Cascade Blonde","Clipper City Gold Ale","Gaffel Koelsch","Genesse Cream Ale","Goose Island Summertme","Hair of the Dog Ruth", "Harp Lager","Harpoon Summer Beer","Kirin Ichiban","Lazy Magnolia","Lord Chesterfield Ave","McSorley's Ale","Nola Blonde","New Belgium Skinny Dip","Pyramid Curve Ball","Redhook Blonde","Reissdorf Koelsch","Sixpoint Sweet Action","Stone Cat Blonde Ale","Victory Golden Monkey","Wexford Irish Cream Ale"]
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
        self.filteredBeers = self.goldenAles.filter {(goldenAles:String) -> Bool in
            if goldenAles.lowercaseString.containsString(self.searchControler.searchBar.text!.lowercaseString){
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
            return self.goldenAles.count
        }else
        {
            return self.filteredBeers.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
        
    {
        let cell = UITableViewCell()
        
        if tableView == self.tableView{
            cell.textLabel?.text = self.goldenAles[indexPath.row]
        }else{
            cell.textLabel?.text = self.filteredBeers[indexPath.row]
        }
        
        return cell
        
    }
    
    
}