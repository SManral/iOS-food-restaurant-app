//
//  SidebarMenuController.swift
//  Paladar
//
//  Created by Smriti Manral on 10/2/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import Firebase

class SidebarMenuController: UITableViewController {
    
   
    @IBOutlet weak var ProfilePic: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setPic()
        ProfilePic.layer.cornerRadius = ProfilePic.frame.size.width/2
        ProfilePic.layer.borderWidth = CGFloat(4.0)
        ProfilePic.layer.borderColor = UIColor.whiteColor().CGColor
        ProfilePic.clipsToBounds = true
    
    }
    
    
    func setPic(){
        let userID = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users/\(userID!)").observeSingleEventOfType(.Value, withBlock: { snapshot in
            let picUrl = snapshot.childSnapshotForPath("/profileImageURL")
            let desc = snapshot.childSnapshotForPath("/description")
            
            let urlString = NSURL(string: picUrl.value as! String)
            
            NSURLSession.sharedSession().dataTaskWithURL(urlString!) { (data, response, error) in
                if error != nil {
                    print(error)
                    return
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.ProfilePic?.image = UIImage(data: data!)
                })
                }.resume()
        })
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let identifier = segue.identifier{
            
            switch identifier{
                
            case "signOut":
                try! FIRAuth.auth()!.signOut()
            default:
                print("identifier not found")
            }
            
        }
    }
    
}
