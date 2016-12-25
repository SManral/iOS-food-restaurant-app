//
//  SweetsTableViewController.swift
//  Paladar
//
//  Created by zhengf on 10/16/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SweetsTableViewController: UITableViewController {
    
    var dbRef: FIRDatabaseReference!
    var comments = [Comments]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbRef = FIRDatabase.database().reference().child("User's comments")
        startObservingDB()
    }
    
    func startObservingDB (){
        dbRef.observeEventType(.Value, withBlock: {(snapshot:FIRDataSnapshot) in
            var newSweets = [Comments]()
            for sweet in snapshot.children {
                let sweetObject = Comments(snapshot: sweet as! FIRDataSnapshot)
                newSweets.append(sweetObject)
            }
            self.comments = newSweets
            self.tableView.reloadData()
        
        }) {
            (error:NSError) in
            print(error.description)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    
    @IBAction func addSweet(sender: AnyObject) {
        let sweetAlert = UIAlertController(title: "New Comment", message: "Enter your Comment", preferredStyle: .Alert)
        sweetAlert.addTextFieldWithConfigurationHandler { (textField:UITextField) in
            textField.placeholder = "Your comment"
        }
        sweetAlert.addAction(UIAlertAction(title: "Send", style: .Default, handler:{ (action:UIAlertAction) in
            if let sweetContent = sweetAlert.textFields?.first?.text{
//                FIRAuth.auth()?.addAuthStateDidChangeListener({(auth:FIRAuth,user:FIRUser?) in
//                    if let user = user{
//                        print("Welcome\(user.email)")
//                        self.startObservingDB()
//                    }
                
                    let sweet = Comments(content: sweetContent, addedByUser: "Guest")
                    let sweetRef = self.dbRef.child(sweetContent.lowercaseString)
                    sweetRef.setValue(sweet.toAnyObject())
                    
//                })
                
            }
            
            
        }))
        self.presentViewController(sweetAlert, animated: true, completion: nil)
    }   
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CELL", forIndexPath: indexPath)
        let comment = comments[indexPath.row]
        
        cell.textLabel?.text = comment.content
        cell.detailTextLabel?.text = comment.addedByUser
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            let sweet = comments[indexPath.row]
            sweet.itemRef?.removeValue()
        }
    }
}