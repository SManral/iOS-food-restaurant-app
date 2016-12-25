//
//  LoginViewController.swift
//  Paladar
//
//  Created by sasa cocic on 9/12/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

var pass = ""
class LoginViewController: UIViewController {
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pass = password.text!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        if let user = FIRAuth.auth()?.currentUser {
            self.signUserIn(user)
        }
        else{
            return
        }
    }
    
    //MARK: - Login Properties
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    // MARK: - Login Logic

    /**
     Signs the user in
     
     - parameter user: FIRUser that will be login in
     */
    func signUserIn(user: FIRUser?) {
        //performSegueWithIdentifier("MapSegue", sender: nil) //redirects users to map
        performSegueWithIdentifier("moveToHome", sender: self)
    }
    
    /**
     Will sign the user in with the provided email and password
     */
    @IBAction func signIn() {
        let email = self.email.text!
        let password = self.password.text!
     
        FIRAuth.auth()!.signInWithEmail(email, password: password) { (user,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.signUserIn(user) // if we get to here then the user has been signed in
            print (user)
        }
    }
    
    /**
     Will navigate the user to another page to begin the process of creating an account
     */
    @IBAction func signUp() {
        //This does nothing as of right now but might be used later for some additional logic
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        switch identifier {
            case "moveToHome":
                if let user = FIRAuth.auth()?.currentUser {
                    print("\(user.email) is signed in")
                    return true
                }
                else{
                    print("NO ONE IS SIGNED IN!")
                    return false
                }
        default:
            print("the identifier was not recognized")
        }
        
        
        return true
    }

}


