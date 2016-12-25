//
//  RecipesViewController.swift
//  Paladar
//
//  Created by Smriti Manral on 11/1/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation

class RecipesViewController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet var SearchRecipeTextF: UITextField!
    
    
    //var recipeSearch = ""
    var apiKey = "25d9e66c758951a37097d2e5b45a3ec0"
    var apiID = "c803218a"
    var endpoint: String = ""
    var searchRecipe = ""
    var searchRecipeText = ""
    
    
    
    //instance variables for recipe attributes
    var recipeName:[String] = []
    var ingridients:[String] = []
    var Cuisine = ""
    var rating = ""
    var id = ""
    var imageURL:[String] = []
    var imageView:[UIImageView] = []
    var timeInSeconds:[Float] = []
    var sourceDisplayName = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
           }
    
    
    
    @IBAction func SearchButton(sender: UIButton) {
                if let recipe = SearchRecipeTextF.text {
                    searchRecipe = recipe
                }
                //search recipe API call
        searchRecipeText = (SearchRecipeTextF.text!).stringByReplacingOccurrencesOfString(" ", withString: "+")
                endpoint = "http://api.yummly.com/v1/api/recipes?_app_id=c803218a&_app_key=25d9e66c758951a37097d2e5b45a3ec0&q=\(searchRecipeText)"
                Alamofire.request(.GET, endpoint).responseJSON { response in
                    if response.result.isSuccess {
                        let data = response.result.value as! NSDictionary
                         print(data)
                        if let matches = data["matches"] as? [[String: AnyObject]] {
                            for match in matches {
        
                                if let name = match["recipeName"] as? String {
                                    self.recipeName.append(name);
                                    //print(self.recipeName)
                                    }
                                if let urlArray = match["imageUrlsBySize"] as? [String: AnyObject] {
                                    if let url = urlArray["90"] as? String {
                                    self.imageURL.append(url);
                                    //print(self.imageURL)
                                    }
                                }
                                if let time = match["totalTimeInSeconds"] as? Int{
                                    let timeInMin: Float = Float(time)/60
                                    self.timeInSeconds.append(timeInMin)
                                    //print(self.timeInSeconds)
                                }
                                }
                            }
                                   }
                    else if response.result.isFailure {
                        print("Bad request")
                    }
                    
                }
            }
     
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "transferDataSegue")
        {
            //Create the instance
            let secondViewController = segue.destinationViewController as! SearchRecipeTViewController;

            //Set the value
            searchRecipeText = (SearchRecipeTextF.text!).stringByReplacingOccurrencesOfString(" ", withString: "+")
            print (searchRecipeText)
            secondViewController.toPass = "q=\(searchRecipeText)";
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
