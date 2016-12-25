//
//  InfoTable.swift
//  Paladar
//
//  Created by sasa cocic on 10/29/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import Firebase

class InfoTable: UITableViewController {
    
    var dinnerKeyValues = [String : String]()
    var userName : String?
    var menuName : String?
    var dpName : String?
    
    var dinnerPartyKeyValues = [(key: String, value: String)]()
    
    var dinnerPartyId : String? = nil
    
    //MARK - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = FIRDatabase.database().reference()
        // retrieve the dinner party that we need from the database
        
        db.child("DinnerParty/\(dinnerPartyId!)").observeSingleEventOfType(.Value) { (snap,err) in
            self.dinnerKeyValues = snap.value as! [String : String]
            self.dpName = self.dinnerKeyValues["name"]
            let menuId = self.dinnerKeyValues["menu"]!
            db.child("users/\(self.dinnerKeyValues["user"]!)").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                var userDict = snapshot.value as! [String : AnyObject]
                self.userName = userDict["username"] as! String
                let titleMenu = snapshot.childSnapshotForPath("/Menus/\(menuId)").value as! String
                self.menuName = titleMenu
                dispatch_async(dispatch_get_main_queue(), {
                    self.rest()
                    self.tableView.reloadData()
                })
            })
        }
    }
    
    func rest(){
        for (key, value) in dinnerKeyValues {
            dinnerPartyKeyValues.append(("\(key)", "\(value)"))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dinnerPartyKeyValues.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(dinnerPartyKeyValues[indexPath.section].key == "menu"){
            performSegueWithIdentifier("menuDisplay", sender: tableView.cellForRowAtIndexPath(indexPath))
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mycell", forIndexPath: indexPath)
        
        cell.textLabel!.text! = dinnerPartyKeyValues[indexPath.section].key
        cell.detailTextLabel?.text! = dinnerPartyKeyValues[indexPath.section].value
        if dinnerPartyKeyValues[indexPath.section].key == "user"{
            cell.detailTextLabel?.text! = userName!
        }
        if dinnerPartyKeyValues[indexPath.section].key == "menu"{
            cell.detailTextLabel?.text! = menuName!
        }

        // Configure the cell...

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier{
            switch identifier{
                case "menuDisplay":
                    if let cell = sender as? UITableViewCell{
                        //let ip = tableView.indexPathForCell(cell)
                        if let vc = segue.destinationViewController as? DinnerPartyInfoController{
//                            vc.menuId = cell.detailTextLabel!.text!
                            vc.menuId = dinnerKeyValues["menu"]!
                        }
                    }
                default:
                    print("error. no such identifier")
                }
            
            }
        }
 

}
