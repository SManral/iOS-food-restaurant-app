//
//  OrderTableController.swift
//  Paladar
//
//  Created by sasa cocic on 10/23/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import Firebase
class OrderTableController: UITableViewController {
    
    
    var queryType : String? = nil
    var placesToOrderFrom = [(id: String, username: String)]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return placesToOrderFrom.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("orderCell", forIndexPath: indexPath)

        // Configure the cell...
        let int = indexPath.row
        cell.textLabel!.text! = placesToOrderFrom[int].username

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - get users to display
    
    private func getUsers(){
        
        let db = FIRDatabase.database().reference()
        db.child("/users").observeSingleEventOfType(.Value) { (snapshot,error) in
            if let values = snapshot.value as? [String : AnyObject]{
                for (key, value) in values{
                    let keyValueDict = value as! [String : AnyObject]
                    for (userKey,userValue) in value as! [String : AnyObject]{
                        if (userKey == "role" && (userValue as? String == "Chef" || userValue as? String == "Resturant" || userValue as? String == "Bar")){
                            self.placesToOrderFrom.append((key,keyValueDict["username"]! as! String))
                        }
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), { 
                self.tableView.reloadData()
            })
        }
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier{
            switch identifier{
            case "showMenu":
                if let cell = sender as? UITableViewCell{
                    let indexPath = self.tableView.indexPathForCell(cell)
                    let data = placesToOrderFrom[indexPath!.row].id //pass this to display data about that user
                    if let vc = segue.destinationViewController as? menuDisplayAndPay{
                        vc.userId = data
                    }
                    
                }
            default:
                print("error. Identifier not found.")
            }
        }
    }
    

}
