//
//  DinnerPartyCreationController.swift
//  Paladar
//
//  Created by sasa cocic on 10/17/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import Firebase

class DinnerPartyCreationController: UIViewController{
    
    // MARK: - Properties
    

    @IBOutlet weak var dinnerPartyName: UITextField!
    @IBOutlet weak var associatedMenu: UILabel!
    @IBOutlet weak var foodType: UITextField!
    
    var timeFormatter = NSDateFormatter()
    var timeOfDinnerParty: String?
    var currentUser: FIRUser?
    var selectedMenu : String?

    @IBOutlet weak var datePicker: UIDatePicker!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        timeFormatter.timeStyle = .ShortStyle
        currentUser = FIRAuth.auth()?.currentUser
        timeOfDinnerParty = timeFormatter.stringFromDate(datePicker.date)//might crash my application
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Save the time for the party
    @IBAction func dateDidChange(sender: UIDatePicker) {
        timeOfDinnerParty = timeFormatter.stringFromDate(sender.date)
    }
    
    //TODO make swift package with the list of all of the names of the tables....
    @IBAction func createDinnerParty() {
        let db = FIRDatabase.database().reference()
        //Do some validation to make sure all of the needed things are being entered
        
        if let dPName = dinnerPartyName.text {
            if let ft = foodType.text {
                if let time = timeOfDinnerParty {
                    let userId = FIRAuth.auth()?.currentUser!.uid
                    let values = ["time" : time,
                                  "name" : dPName,
                                  "foodType" : ft,
                                  "user" : userId!,
                                  "menu" : selectedMenu!
                                 ]
                    //need to do validation on selectedMenu
                    db.child("/DinnerParty").childByAutoId().setValue(values)
                    
                }
            }
        }
        
    }
    

    @IBAction func pickMenu() {
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier{
            let db = FIRDatabase.database().reference()
            switch identifier {
            case "CreateMenu":
                if let vc = segue.destinationViewController as? CreateMenuController {
                    let childId = db.child("/Menus").childByAutoId()
                    vc.menuLocation = childId
                }
            case "pickMenu":
                if let vc = segue.destinationViewController as? MenuPicker {
                    vc.currentUser = currentUser!.uid
                }
            default:
                print("error something went wrong")
            }
        }
        
    }
    
    @IBAction func goBack(segue : UIStoryboardSegue){
        
        if let vc = segue.sourceViewController as? MenuPicker{
            self.selectedMenu = vc.pickedRow.name!
            associatedMenu.text! = vc.pickedRow.key!
        }
        
    }
    

}
