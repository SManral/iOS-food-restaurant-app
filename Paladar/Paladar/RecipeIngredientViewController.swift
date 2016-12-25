//
//  RecipeIngredientViewController.swift
//  Paladar
//
//  Created by Smriti Manral on 12/4/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit

class RecipeIngredientViewController: UIViewController {

    @IBOutlet weak var IngredientsTA: UITextView!
    var ingredients:[String] = []
    var ingString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        for ingredient in ingredients{
            ingString += ("\(ingredient as! String) \n")
        }
         IngredientsTA.text = (ingString)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
