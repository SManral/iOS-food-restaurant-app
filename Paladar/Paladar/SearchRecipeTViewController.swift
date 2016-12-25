//
//  SearchRecipeTViewController.swift
//  Paladar
//
//  Created by Smriti Manral on 11/7/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//
//commenting to test
//comment 2
import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage


class SearchRecipeTViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var SearchRecipesTable: UITableView!
    @IBOutlet var RecipesLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!{
        didSet{ tableView.delegate = self; tableView.dataSource = self; }
    }
    var toPass:String!

    
    var apiKey = "25d9e66c758951a37097d2e5b45a3ec0"
    var apiID = "c803218a"
    var endpoint: String = ""
    var trimmedString = ""
    
    //instance variables for recipe attributes
    var recipeName:[String] = []
    var ingridients:[String] = []
    var Cuisine = ""
    var rating = ""
    var recipeId:[String] = []
    var imageURL:[String] = []
   // var imageView:UIImageView?
    var timeInSeconds:[Int] = []
    var sourceDisplayName = ""
    
    
    //var names = [String]()
   // var image = [UIImage(named:"cy"),UIImage(named:"menu"),UIImage(named:"menu")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let trimmedString = toPass.stringByTrimmingCharactersInSet(
//            NSCharacterSet.whitespaceAndNewlineCharacterSet())
//        print (trimmedString)
        RecipesLabel.text = ("Found 10 Search Results")
        apiCall()
       // print ("size of array is \(recipeName.count)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func apiCall()
    {
        //search recipe API call
        endpoint = "http://api.yummly.com/v1/api/recipes?_app_id=c803218a&_app_key=25d9e66c758951a37097d2e5b45a3ec0&\(toPass)&requirePictures=true"
        Alamofire.request(.GET, endpoint).responseJSON { response in
            if response.result.isSuccess {
                let data = response.result.value as! NSDictionary
                // print(data)
                if let matches = data["matches"] as? [[String: AnyObject]] {
                    for match in matches {
                        
                        if let name = match["recipeName"] as? String {
                            self.recipeName.append(name);
                      //  print("Test123 \(self.recipeName[0])")
                        }
                        if let id = match["id"] as? String {
                            self.recipeId.append(id);
                            print(id)
                        }
                        if let urlArray = match["imageUrlsBySize"] as? [String: AnyObject] {
                            if let url = urlArray["90"] as? String {
                                self.imageURL.append(url);
                            }
                        }
                        if let time = match["totalTimeInSeconds"] as? Int{
                            let timeInMin = (time)/60
                            self.timeInSeconds.append(timeInMin)
                           // print(timeInMin)
                        }
                    }
                    dispatch_async(dispatch_get_main_queue(), { 
                        self.tableView.reloadData()
                    })
                }
            }
            else if response.result.isFailure {
                print("Bad request")
            }
            
        }
      //  print("Test123 \(self.recipeName)")
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeName.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! SearchRecipeCell
        cell.RecipeNameTA.text = recipeName[indexPath.row]
        cell.RecipeTime.text = ("\(timeInSeconds[indexPath.row].description) minutes")
        cell.RecipeImage.sd_setImageWithURL(NSURL(string: imageURL[indexPath.row]))

        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //print (indexPath)
        //performSegueWithIdentifier("RecipeDetailSegue", sender: indexPath);
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "RecipeDetailSegue") {
            if let destination = segue.destinationViewController as? RecipeDetailViewController
            {
                let path = self.tableView.indexPathForSelectedRow
                //let cell = tableView.cellForRowAtIndexPath(path!)as! SearchRecipeCell
                //Set the value
                destination.recipename = recipeName[path!.row]
                destination.recipeid = recipeId[path!.row]

            }
            
        }
    }
    
}
