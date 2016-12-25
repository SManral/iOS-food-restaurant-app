//
//  RestaurantWebViewController.swift
//  Paladar
//
//  Created by Smriti Manral on 12/4/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class RestaurantWebViewController: UIViewController {

    
    @IBOutlet weak var RestWebView: UIWebView!
    var username=""
    var userType=""
    var password=""

    override func viewDidLoad() {
        super.viewDidLoad()
       getUP()
       
       // print(email)
        //print(userType)
        
        // Do any additional setup after loading the view.
    }
    func getUP(){
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        FIRDatabase.database().reference().child("users/\(userID!)").observeSingleEventOfType(.Value, withBlock: { snapshot in
            let userEmail = snapshot.childSnapshotForPath("/username")
            let userType = snapshot.childSnapshotForPath("/role")
            self.username = userEmail.value as! String
            self.userType = userType.value as! String
            if(self.userType=="User"){
            //let url = NSURL (string:"http://localhost:3000/testUri?username=\(self.username)&password=\(self.password)");
                let url = NSURL (string:"http://localhost:3000/#/users_home")
                let requestObj = NSURLRequest(URL: url!);
                self.RestWebView.loadRequest(requestObj);
                }
            else if (self.userType=="Resturant" || self.userType=="Chef"){
                let url = NSURL (string:"http://localhost:3000/#/login")
                let requestObj = NSURLRequest(URL: url!);
                self.RestWebView.loadRequest(requestObj);
            }
            return
        })
            }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   }
