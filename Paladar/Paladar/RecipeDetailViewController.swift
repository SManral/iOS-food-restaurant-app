//
//  RecipeDetailViewController.swift
//  Paladar
//
//  Created by Smriti Manral on 11/10/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class RecipeDetailViewController: UIViewController {

    @IBOutlet var RName: UILabel!
    @IBOutlet var RTime: UILabel!
    @IBOutlet var RServings: UILabel!
    @IBOutlet var RImage: UIImageView!
    @IBOutlet var RCalories: UILabel!
    
    var endpoint: String = ""
    var recipename = ""
    var recipeid = ""
    var sourceUrl = ""
    var ingArray: [String] = []

    var ingredientsString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
//        RIngredients.layer.borderWidth = 1
//        RIngredients.layer.borderColor = UIColor.whiteColor().CGColor
        RName.text = recipename
        print (recipeid)
        apiCall()
       
        
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func apiCall()
    {
        endpoint = "http://api.yummly.com/v1/api/recipe/\(recipeid)?_app_id=c803218a&_app_key=25d9e66c758951a37097d2e5b45a3ec0"
        print (endpoint)
        Alamofire.request(.GET, endpoint).responseJSON { response in
            if response.result.isSuccess {
                let data = response.result.value as! NSDictionary
                //print (data)
                if let servings = data["numberOfServings"] as? Int{
                    self.RServings.text = ("Servings: \(servings.description)")
                }
                if let time = data["totalTime"] as? String {
                    self.RTime.text = ("Cooking plus Prep time: \(time)")
                }
                if let imageUrlArr = data["images"] as? [[String: AnyObject]] {
                    for imageUrl in imageUrlArr{
                        if let url = imageUrl["hostedLargeUrl"] as? String {
                            self.RImage.sd_setImageWithURL(NSURL(string: url))
                        }
                    }
                }
                if let nutririonArr = data["nutritionEstimates"] as? [[String: AnyObject]] {
                    for nutrion in nutririonArr{
                        if let calories = nutrion["value"] as? Int {
                            print (calories)
                            self.RCalories.text=("Calories: \(calories.description) cal")
                            
                            // self.RTime.text = ("Cooking plus Prep time: \(time)")
                        }
                    }
                }
                if let ingredients = data["ingredientLines"] as? NSArray {
                    for ingredient in ingredients{
                        self.ingredientsString += ("\(ingredient as! String) \n")
                        self.ingArray.append(ingredient as! String)
                    }
                }
                if let source = data["source"] as? [String: AnyObject] {
                    if let sUrl = source["sourceRecipeUrl"] as? String {
                        self.sourceUrl = sUrl;
                    }
                }
                
            }
            else if response.result.isFailure {
                print("Bad request")
            }
    }
    
    }
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "RecipetoWebSegue") {
            if let destination = segue.destinationViewController as? RecipeWebViewController
            {
                destination.sourceUrl = self.sourceUrl
            }
        }
        else if (segue.identifier == "RecipetoIngredientsSegue") {
            if let destination = segue.destinationViewController as? RecipeIngredientViewController
            {
                destination.ingredients = self.ingArray
            }
        }

    }
    

}
