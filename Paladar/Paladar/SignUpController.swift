//
//  SignUpController.swift
//  Paladar
//
//  Created by sasa cocic on 9/23/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var chefButton: UIButton!
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var deliveryButton: UIButton!
    @IBOutlet weak var resturantButton: UIButton!
    @IBOutlet weak var barButton: UIButton!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier{
            switch identifier {
            case "isDelivery":
                if let vc = segue.destinationViewController as? RegisterController {
                    vc.userType = deliveryButton.titleLabel!.text!
                }
            case "isChef":
                if let vc = segue.destinationViewController as? RegisterController {
                    vc.userType = chefButton.titleLabel!.text!
                }
            case"isUser":
                if let vc = segue.destinationViewController as? RegisterController {
                    vc.userType = userButton.titleLabel!.text!
                }
            case "isResturant":
                if let vc = segue.destinationViewController as? RegisterController {
                    vc.userType = resturantButton.titleLabel!.text!
                }
            case "isBar":
                if let vc = segue.destinationViewController as? RegisterController {
                    vc.userType = barButton.titleLabel!.text!
                }
                
            default:
                print("error something went wrong")
            }
        }
        
    }
    

}
