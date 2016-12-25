//
//  RegisterController.swift
//  Paladar
//
//  Created by sasa cocic on 9/23/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class RegisterController: UIViewController {
    
    // Mark: - Properties
    
    var userType: String = "" //Gets set when this screen is segued to
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var streetAddress: UITextField!
    @IBOutlet weak var phoneNumber: UITextField! //leave formatting later
    @IBOutlet weak var userName: UITextField!
    
    
    
    
    var ref: FIRDatabaseReference!
    
    
    // Mark: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: - Actions
    
    @IBAction func createUser() {
        
        self.ref = FIRDatabase.database().reference() //reference to the database
        
        if email.text!.isEmpty || password.text!.isEmpty {
            self.errorLabel.text! = "email or password is empty"
        }
        else{
            FIRAuth.auth()?.createUserWithEmail(email.text!, password: password.text!) { (user,error) in
                if let err = error {
                    print(err.localizedDescription)
                    self.errorLabel.text! = err.localizedDescription
                }
                else{
                    let values = ["email" : user!.email!,
                                  "role" : self.userType,
                                  "city": self.city.text!,
                                  "state" : self.state.text!,
                                  "zipCode": self.zipCode.text!,
                                  "streetAddress" : self.streetAddress.text!,
                                  "phoneNumber" : self.phoneNumber.text!,
                                  "userName" : self.userName.text!]
                    
                    self.ref.child("users/\(user!.uid)").setValue(values)
                    self.errorLabel.text! = ""
                    
                    //navigate to home screen
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    //let next = storyBoard.instantiateViewControllerWithIdentifier("signIn")
                    let next = storyBoard.instantiateViewControllerWithIdentifier("ProfileSetup")
                    self.presentViewController(next, animated: true, completion: nil)
                }
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
