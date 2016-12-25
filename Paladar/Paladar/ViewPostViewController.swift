//
//  ViewPostViewController.swift
//  Paladar
//
//  Created by Smriti Manral on 10/30/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import Firebase

class ViewPostViewController: UIViewController  {
    @IBOutlet weak var ProfilePic: UIImageView!
    @IBOutlet weak var messageField: UITextView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    let ref = FIRDatabase.database().reference()
    
    var subCatList: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfilePic.layer.cornerRadius = ProfilePic.frame.size.width/2
        ProfilePic.layer.borderWidth = CGFloat(4.0)
        ProfilePic.layer.borderColor = UIColor.whiteColor().CGColor
        ProfilePic.clipsToBounds = true
        
       // let userRef = ref.child("DecisionPost");
        //retrieving names of restaurants from database
        //userRef.queryOrderedByChild("Sub-category list").observeEventType(.Value, withBlock: {
          //  snapshot in
//            for child in snapshot.children {
//                subCatList.append = child.value["Sub-category list"] as! String            }
//        })
    }

    
    //    func senderInfo(){
    //        //retrieving data from firebase and putting in it in an array to use it in pickerView
    //        let userRef = ref.child("DecisionPost");
    //
    //        //retrieving names of restaurants from database
    //        userRef.queryOrderedByChild("sender").queryEqualToValue("Sender").observeEventType(.Value, withBlock: {
    //            snapshot in
    //            for child in snapshot.children {
    //                let senderName = child.value["sender"] as! String
    //                self.usernameLabel.text = senderName
    //            }
    //        })
    //
    //        let userRef = ref.child("users");
    //
    //        //retrieving names of restaurants from database
    //        userRef.queryOrderedByChild("role").queryEqualToValue("Sender").observeEventType(.Value, withBlock: {
    //            snapshot in
    //            for child in snapshot.children {
    //                let senderPic = child.absoluteURL["profileImageURL"] as! String
    //                self.ProfilePic.image =
    //            }
    //        })
    //
    //    }
    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        return UITableViewCell()
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//    }
//    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
