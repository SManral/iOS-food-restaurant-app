//
//  TBVC.swift
//  Paladar
//
//  Created by Julio Salinas on 10/18/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit

extension TableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}



class TableViewController: UITableViewController {
    
    
    var names = [
        Names(category:"Restaurant", name:"Papa Johns"),
        Names(category:"Restaurant", name:"Restoan Victoria Station"),
        Names(category:"Restaurant", name:"James Foo Western Food"),
        Names(category:"Fast Food", name:"KFC"),
        Names(category:"Fast Food", name:"McDonald's"),
        Names(category:"Fast Food", name:"Subway"),
        Names(category:"Other", name:"Insomnia Cookies"),
        Names(category:"Other", name:"Cold Stone Creamery"),
        Names(category:"Other", name:"Culver's")
    ]
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredCandies = [Names]()
    var identities = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        identities = ["AAAAA","AAAAA","AAAAA","AAAAA","AAAAA","AAAAA","AAAAA","AAAAA","AAAAA"]
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredCandies = names.filter { names in
            return names.name.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table View
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredCandies.count
        }
        return names.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let name: Names
        if searchController.active && searchController.searchBar.text != "" {
            name = filteredCandies[indexPath.row]
        } else {
            name = names[indexPath.row]
        }
        cell.textLabel?.text = name.name
        cell.detailTextLabel?.text = name.category
        return cell
    }
    
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let name: Names
                if searchController.active && searchController.searchBar.text != "" {
                    name = filteredCandies[indexPath.row]
                } else {
                    name = names[indexPath.row]
                }
                
            }
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vcName = identities[indexPath.row]
        let viewController = storyboard?.instantiateViewControllerWithIdentifier(vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)
        
    }
    
    
}
