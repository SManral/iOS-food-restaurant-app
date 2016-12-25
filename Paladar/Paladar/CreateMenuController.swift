//
//  CreateMenuController.swift
//  Paladar
//
//  Created by sasa cocic on 10/21/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import Firebase

class CreateMenuController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerSections = [String]()
    var prices =
        [
        ["$1", "10"],
        ["$2", "20"],
        ["$3","30"],
        ["$4", "40"],
        ["$5", "50"],
        ["$6", "60"],
        ["$7", "70"],
        ["$8", "80"],
        ["$9", "90"]
        ]
    var menu = [[String]]()
    var menuLocation : FIRDatabaseReference?
    var currentRowForPicker : String?
    var currentPrice = ["$1", "10"]
    let currentUser = FIRAuth.auth()?.currentUser
    
    @IBOutlet weak var menuField: UITextField!
    @IBOutlet weak var pricePicker: UIPickerView!
    @IBOutlet weak var sectionPicker: UIPickerView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var mealField: UITextField!
    
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            getLatestMenu()
        }
    }
    
    
    // MARK: -- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sectionPicker.delegate = self
        sectionPicker.dataSource = self
        pricePicker.delegate = self
        pricePicker.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Actions
    
    @IBAction func AddSection() {
        let titleText = titleField.text!
        let mealText = mealField.text!
        let menuText = menuField.text!
        if(!(titleText.isEmpty && mealText.isEmpty && menuText.isEmpty)){
            let price = "\(currentPrice[0]).\(currentPrice[1])"
            FIRDatabase.database().reference().child("users/\(currentUser!.uid)/Menus/\(menuLocation!.key)").setValue("\(menuText)")
            
            menuLocation?.child(titleText).child(mealText).setValue(price)
            titleField.text! = ""
            menu = [[String]]()
            pickerSections = [String]()
            getLatestMenu()
            if currentRowForPicker == nil{
                currentRowForPicker = titleText
            }
        }
        
    }
    

    @IBAction func addRow() {
        let mealText = mealField.text!
        if let section = currentRowForPicker{ //the current row has been picked
            if !mealText.isEmpty{
                let price = "\(currentPrice[0]).\(currentPrice[1])"
                menuLocation?.child("\(section)/\(mealText)").setValue(price)
                menu = [[String]]()
                pickerSections = [String]()
                getLatestMenu()
            }
        }
        
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return menu.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FoodType", forIndexPath: indexPath)
        
        cell.textLabel!.text! = menu[indexPath.section][indexPath.row]
        
        return cell
    }
    
    
    // MARK: - Table view retreval
    
    func getLatestMenu(){
        
        FIRDatabase.database().reference().child("Menus/\(menuLocation!.key)").observeSingleEventOfType(.Value) { (snapshot,error) in
            if let values = snapshot.value as? [String : AnyObject]{
                for (menuKey,menuValue) in values{
                    if !(menuKey == "created By" || menuKey == "menu Name"){
                        self.pickerSections.append(menuKey)
                        let keyValues = menuValue as! [String : String]
                        var adding = ["\(menuKey)"]
                        for (menuRowKey,menuRowValue) in keyValues{
                            adding.append("\(menuRowKey) - \(menuRowValue)")
                            
                        }
                        self.menu.append(adding)
                    }
                    
                    
                }
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                self.sectionPicker.reloadAllComponents()
            })
        }
        
    }
    
    // Mark: - Picker view data source
    
    /*
     Asks for the number of coulmns in the view picker e.g. if you had
     time you might want 3 for hour,min.,sec
     */
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if pickerView == sectionPicker{
            return 1
        }
        return 2
    }
    
    /*
     Asks you to return how many rows will be in the picker
     */
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == sectionPicker){
            return pickerSections.count
        }
        return prices.count
    }
    
    /*
     Asks for the specific data in the row and coulmn
     */
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == sectionPicker{
            return pickerSections[row]
        }
        return prices[row][component]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == sectionPicker){
            currentRowForPicker = pickerSections[row]
        }
        else{
            currentPrice[component] = prices[row][component]
        }
    }
    
    
    //get things then reload table

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
