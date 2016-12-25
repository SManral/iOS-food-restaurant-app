//
//  SearchFoodController.swift
//  Paladar
//
//  Created by sasa cocic on 10/15/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit

class SearchFoodController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - Properties
    
    
    @IBOutlet weak var FoodPrepPicker: UIPickerView!
    @IBOutlet weak var foodType: UIPickerView!
    
    
    var foodPrepers = [String]()
    var foodTypes = [String]()
    
    
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FoodPrepPicker.delegate = self
        FoodPrepPicker.dataSource = self
        foodType.delegate = self
        foodType.dataSource = self
        
        foodPrepers.append("Chef")
        foodPrepers.append("Resturant")
        
        foodTypes.append("Any")
        foodTypes.append("New American")
        foodTypes.append("Italian")
        foodTypes.append("Asain")
        foodTypes.append("Desert")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func viewAllMeals() {
        //TODO query and go view all to go meals
    }
    
    
    
    // MARK: - Protocols
    
    /*
     Asks for the number of coulmns in the view picker e.g. if you had 
     time you might want 3 for hour,min.,sec
     */
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /*
     Asks you to return how many rows will be in the picker
     */
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == FoodPrepPicker{
            return foodPrepers.count
        }
        else{
            return foodTypes.count
        }
        
    }
    
    /*
     Asks for the specific data in the row and coulmn
     */
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == FoodPrepPicker{
            return foodPrepers[row]
        }
        else{
            return foodTypes[row]
        }
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier{
            switch identifier {
            case "viewAll":
                if let vc = segue.destinationViewController as? OrderTableController{
                    vc.queryType = "all"
                }
            default:
                print("error no identifier found")
            }
            
        }
    }
    

}
