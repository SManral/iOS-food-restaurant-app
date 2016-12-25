//
//  RecipeCuisineViewController.swift
//  Paladar
//
//  Created by Smriti Manral on 12/3/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class RecipeCuisineViewController: UIViewController {

    @IBOutlet weak var CuisineText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "trasferDataSegue3")
        {
            //Create the instance
            let secondViewController = segue.destinationViewController as! SearchRecipeTViewController;
            
            //Set the value
            secondViewController.toPass = "q=\(CuisineText.text!)"
            //secondViewController.toPass = "q=\(SearchRecipeTextF.text!)";
        }      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
