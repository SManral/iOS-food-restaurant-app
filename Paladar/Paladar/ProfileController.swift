//
//  ProfileController.swift
//  Paladar
//
//  Created by sasa cocic on 9/20/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import Firebase

class ProfileController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    func setBorderColors(){
        usernameLabel.layer.borderWidth = 1
        usernameLabel.layer.borderColor = UIColor.blackColor().CGColor
        
        bioLabel.layer.borderWidth = 1
        bioLabel.layer.borderColor = UIColor.blackColor().CGColor
        
        bodyLabel.layer.borderWidth = 1
        bodyLabel.layer.borderColor = UIColor.blackColor().CGColor
        
        profilePicture.layer.borderWidth = 1
        profilePicture.layer.borderColor = UIColor.blackColor().CGColor
        
    }
    
    override func viewDidLoad() {
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = Selector("revealToggle:")
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        setBorderColors()
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users/\(userID!)").observeSingleEventOfType(.Value, withBlock: { snapshot in
            let picUrl = snapshot.childSnapshotForPath("/profileImageURL")
            let desc = snapshot.childSnapshotForPath("/description").value as! String
            let userName = snapshot.childSnapshotForPath("/username").value as! String
            //if there menus exist get them then display them otherwise show no menus
            
            let urlString = NSURL(string: picUrl.value as! String)
            
            NSURLSession.sharedSession().dataTaskWithURL(urlString!) { (data, response, error) in
                if error != nil {
                    print(error)
                    return
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.profilePicture?.image = UIImage(data: data!)
                    self.bioLabel.text! = desc
                    self.usernameLabel.text! = userName
                })
                }.resume()
        })

    }
    

}
