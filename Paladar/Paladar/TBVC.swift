//
//  TBVC.swift
//  Paladar
//
//  Created by Julio Salinas on 10/18/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import Foundation
import UIKit

class TableViewControllerr: UITableViewController{
    
    var names = [String]()
    var identities = [String]()
    
    override func viewDidLoad() {
        names = ["Pale Lager","Pilsners","Golden Ales","Wheat Beers","Pale Ales","IPAs","Amber Ales","Belgian Style Brews","Brown Ales","Dark Lagers","Stouts & Porters", "Unique Brews"]
        identities = ["A","B","C","D","E","F","G","H","I","J","K","L"]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       return names.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
        
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        cell?.textLabel!.text = names[indexPath.row]
        
        return cell!
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let vcName = identities[indexPath.row]
        let viewController = storyboard?.instantiateViewControllerWithIdentifier(vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)
    }

    
    
    
    
}
