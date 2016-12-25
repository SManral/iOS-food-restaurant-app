//
//  DinnerPartyController.swift
//  Paladar
//
//  Created by sasa cocic on 10/9/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import Firebase


class DinnerPartyController: UITableViewController, UIGestureRecognizerDelegate {
    
    var dinnerParties = [(key: String, name: String, menu: String)]()
    
    var refreshing: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDinnerParties()
        
        refreshing = UIRefreshControl()
        refreshing.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshing.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshing)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func refresh(sender:AnyObject) {
        getDinnerParties()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    //the number of sections in that table
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    // the number of rows in each section
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dinnerParties.count
    }

    
    //what to display for each row in each section
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
        
        let data = dinnerParties[indexPath.row].name//indexPath is really just the section and row
        
        if let dp = cell as? DinnerPartyCell {
            
            dp.testLabel.text! = data
        }

        // Configure the cell...

        return cell
    }
    
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//    }
 

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
            case "viewDinnerParty":
                if let cell = sender as? DinnerPartyCell{
                    let indexPath = self.tableView.indexPathForCell(cell)
                    let data = dinnerParties[indexPath!.row].key
                    if let vc = segue.destinationViewController as? InfoTable{
                        vc.dinnerPartyId = data
                    }
                    
                }
            case "buyAndAttend":
                let button = sender as! UIButton
                let view = button.superview!
                let cell = view.superview
                
                if let dpCell = cell as? DinnerPartyCell{
                    let indexPath = self.tableView.indexPathForCell(dpCell)
                    let data = dinnerParties[indexPath!.row].menu
                    if let vc = segue.destinationViewController as? DinnerPartyInfoController{
                        vc.menuId = data
                    }
                    
                }
                
            default:
                print("error: no identifer found")
            }
        }
    }
    
    // MARK: - DB
    
    //Gets all of the dinner parties for to display them
    private func getDinnerParties(){
        
        let db = FIRDatabase.database().reference()
        dinnerParties = [(key: String, name: String, menu: String)]()
        
        db.child("DinnerParty").observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            let enumorator = snapshot.children
            
            while let rest = enumorator.nextObject() as? FIRDataSnapshot{
                let dpName = rest.childSnapshotForPath("name")
                let menu = rest.childSnapshotForPath("menu")
                self.dinnerParties.append((rest.key, dpName.value as! String, menu.value as! String))
            }
            dispatch_async(dispatch_get_main_queue(), { 
                self.tableView.reloadData()
                self.refreshing!.endRefreshing()
            })
            
        })
    }

    
    @IBAction func returnToDinnerParties(segue : UIStoryboardSegue){
        
    
    }
}
