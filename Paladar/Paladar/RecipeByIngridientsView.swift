//
//  RecipeByIngridientsView.swift
//  Paladar
//
//  Created by Smriti Manral on 11/8/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RecipeByIngridientsView: UIViewController,UITextFieldDelegate {
    
    //var recipeSearch = ""
    var apiKey = "25d9e66c758951a37097d2e5b45a3ec0"
    var apiID = "c803218a"
    var endpoint: String = ""
    var searchRecipe = ""
    var arrayOfTextFields:[UITextField] = []

    var AddIngrediants: UITextField = UITextField()
    var plusButton: UIButton = UIButton()
    var IngridientsLabel: UILabel = UILabel()
    var sendButton: UIButton = UIButton()
    var z:CGFloat = 6
    var i:CGFloat = 0
    
    @IBOutlet weak var SubIngredientLabel: UILabel!
     var ingredients:[String] = []
    var allowedIngredients:String = ""
    @IBOutlet var IngrediantsLabel: UILabel!
    //instance variables for recipe attributes
    var recipeName:[String] = []
    var ingridientsList:[String] = []
    var Cuisine = ""
    var rating = ""
    var id = ""
    var imageURL:[String] = []
    var timeInSeconds:[Float] = []
    var sourceDisplayName = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        AddIngrediants.delegate = self
        for (var i = 1; i <= 10 ; i++)
        {
            //func AddingIngTB(z: CGFloat){
            AddIngrediants = UITextField(frame: CGRectMake(40,SubIngredientLabel.frame.maxY+z, 240, 30))
            AddIngrediants.backgroundColor = UIColor.whiteColor()
            AddIngrediants.borderStyle = UITextBorderStyle.RoundedRect;
            AddIngrediants.center.x = self.view.center.x
            self.arrayOfTextFields.append(AddIngrediants)
            self.view.addSubview(AddIngrediants)
            z = z+35
            //AddIngrediants.becomeFirstResponder()
            
            //}
        }
        plusButton = UIButton(frame: CGRect(x:145, y:AddIngrediants.frame.maxY+10, width: 100, height: 35))
        plusButton.backgroundColor = UIColor(hue: 0.5111, saturation: 0.77, brightness: 0.94, alpha: 1.0)
        plusButton.setTitle("Save", forState: UIControlState.Normal)

        plusButton.addTarget(self, action: "addSubCatButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(plusButton)


        // Do any additional setup after loading the view.
    }
    
    func addSubCatButton (sender:UIButton!){
        print ("this button pressed")
        for textField in arrayOfTextFields{
            if(textField.text != ""){
        let ingredient = (textField.text!).lowercaseString
        allowedIngredients += ("allowedIngredient[]=\(ingredient)&")
            }
            else{
            }
        }
       
        var index1 = allowedIngredients.startIndex.advancedBy(((allowedIngredients.characters.count)-1))
        allowedIngredients = allowedIngredients.substringToIndex(index1)
        print (allowedIngredients)

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "transferDataSegue2")
        {
            //Create the instance
            let secondViewController = segue.destinationViewController as! SearchRecipeTViewController;
            
            //Set the value
            secondViewController.toPass = allowedIngredients
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
