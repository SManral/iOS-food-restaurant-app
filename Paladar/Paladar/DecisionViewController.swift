//
//  DecisionViewController.swift
//  Paladar
//
//  Created by Smriti Manral on 10/16/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import Firebase


class DecisionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var CategoryTB: UITextField!
    @IBOutlet weak var subCatLabel: UILabel!
    
    
    
    let CategoryDropDown = UIPickerView()
    let SubCategoryDropDown = UIPickerView()
    var dateTimeDropDown = UIDatePicker()
    var dateTimeField: UITextField = UITextField()
    var addTextField: UITextField = UITextField()
    var messageField: UITextView = UITextView()
    var userLabel: UILabel = UILabel()
    var addUserField: UITextField = UITextField()
    var plusButton: UIButton = UIButton()
    var sendButton: UIButton = UIButton()
    
    //used for firebase
    let ref = FIRDatabase.database().reference()
    var subCategoryList: [String] = []
    var usersList: [String] = []
    
    var chefCat: [String] = []
    var restaurantCat: [String] = []
    var catList = ["Restaurants", "Chefs", "Date", "Time", "Bars", "Custom"]
    var i:CGFloat = 0
    var j:CGFloat = 0
    var z:CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SubCategoryTB(6)
        addSubCatButton(addTextField.frame.maxX+3,buttonHeight: addTextField.frame.minY+2.5)
        addMessage()
        addDateTime()
        addUsersLabel()
        addUsersTB()
        addUsersButton(addUserField.frame.maxX+3,buttonHeight: addUserField.frame.minY+2.5)
        send()
        
        dateTimeField.delegate=self
        addUserField.delegate = self
        
        CategoryDropDown.delegate = self
        CategoryDropDown.tag = 1
        CategoryTB.inputView = CategoryDropDown
        
        SubCategoryDropDown.delegate = self
        SubCategoryDropDown.tag = 2
        addTextField.inputView = SubCategoryDropDown
        
        //retrieving data from firebase and putting in it in an array to use it in pickerView
        let userRef = ref.child("users");
        
        //retrieving names of restaurants from database
        userRef.queryOrderedByChild("role").queryEqualToValue("Resturant").observeEventType(.Value, withBlock: {
            snapshot in
            for child in snapshot.children {
                let name = child.value["email"] as! String
                self.restaurantCat.append(name)
            }
        })
        //retrieving names of chefs from database
        userRef.queryOrderedByChild("role").queryEqualToValue("Chef").observeEventType(.Value, withBlock: {
            snapshot in
            for child in snapshot.children {
                let name = child.value["email"] as! String
                self.chefCat.append(name)
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Gets the number of components for the picker view
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return catList.count
        }
        if pickerView.tag == 2 {
            if(CategoryTB.text == "Restaurants"){
                return restaurantCat.count
            }
            else if(CategoryTB.text == "Chefs"){
                return chefCat.count
            }
            
        }
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return catList[row]
        }
        if pickerView.tag == 2 {
            if(CategoryTB.text == "Restaurants"){
                return restaurantCat[row]
            }
            else if(CategoryTB.text == "Chefs"){
                return chefCat[row]
            }
        }
        return nil
    }
    
    //changes the text field to the selected row in the pickerView
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if pickerView.tag == 1 {
            CategoryTB.text = catList[row]
        }
        if pickerView.tag == 2 {
            if(CategoryTB.text == "Restaurants"){
                addTextField.text = restaurantCat[row]
                subCategoryList.append(addTextField.text!)
                
            }
            else if(CategoryTB.text == "Chefs"){
                addTextField.text = chefCat[row]
                subCategoryList.append(addTextField.text!)
            }
        }
    }
    
    
    //hides the pickerView when user touches outside of the pickerView
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //creates an add button
    func addSubCatButton(buttonWidth: CGFloat, buttonHeight: CGFloat)
    {
        plusButton = UIButton(frame: CGRect(x: buttonWidth, y: buttonHeight, width: 25, height: 25))
        plusButton.setBackgroundImage(UIImage(named: "PlusButton.png"), forState:UIControlState.Normal)
        self.view.addSubview(plusButton)
        plusButton.addTarget(self, action: "addSubCatButton:", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    //creates textfield for subcategory
    func SubCategoryTB(z: CGFloat){
        addTextField = UITextField(frame: CGRectMake(40,subCatLabel.frame.maxY+z, 240, 30))
        addTextField.backgroundColor = UIColor.whiteColor()
        addTextField.borderStyle = UITextBorderStyle.RoundedRect;
        addTextField.center.x = self.view.center.x
        self.view.addSubview(addTextField)
        addTextField.inputView = SubCategoryDropDown
    }
    
    
    //Adds additional text fields for subcategory
    func addSubCatButton (sender:UIButton!){
        i = i+35
        SubCategoryTB(i)
    }
    
    
    //Creates a add message label of type UILabel and a message field which is of type UITextView
    func addMessage() {
        let messageLabel = UILabel(frame: CGRectMake(40, addTextField.frame.maxY+120, 240, 14))
        messageLabel.textAlignment = NSTextAlignment.Center
        messageLabel.text = "Add a message"
        messageLabel.center.x = self.view.center.x
        messageLabel.font=messageLabel.font.fontWithSize(13)
        messageLabel.textColor=UIColor.whiteColor()
        self.view.addSubview(messageLabel)
        
        messageField = UITextView(frame: CGRectMake(40, messageLabel.frame.maxY+6, 240, 60))
        messageField.layer.cornerRadius = 5.0;
        messageField.textColor = UIColor.blueColor()
        messageField.center.x = self.view.center.x
        messageField.backgroundColor = UIColor.whiteColor()
        messageField.scrollEnabled = true
        messageField.editable = true
        self.view.addSubview(messageField)
    }
    
    
    //Creates a date/time picker label of type UILabel and a date picker field which is of type UIDatePicker. This is for the user to set a time frame for the other users to view and respond to the post.
    func addDateTime() {
        let dateTimeLabel = UILabel(frame: CGRectMake(40, messageField.frame.maxY+16, 240, 14))
        dateTimeLabel.textAlignment = NSTextAlignment.Center
        dateTimeLabel.text = "Set a time frame"
        dateTimeLabel.center.x = self.view.center.x
        dateTimeLabel.font=dateTimeLabel.font.fontWithSize(13)
        dateTimeLabel.textColor=UIColor.whiteColor()
        self.view.addSubview(dateTimeLabel)
        
        dateTimeField = UITextField(frame: CGRectMake(40, dateTimeLabel.frame.maxY+6, 240, 30))
        dateTimeField.backgroundColor = UIColor.whiteColor()
        dateTimeField.borderStyle = UITextBorderStyle.RoundedRect;
        dateTimeField.center.x = self.view.center.x
        dateTimeField.userInteractionEnabled = true
        dateTimeField.addTarget(self, action: "showDateTime:", forControlEvents: UIControlEvents.EditingDidBegin)
        self.view.addSubview(dateTimeField)
        
    }
    
    //This code will initialise datepicker & set its mode to select date. After that set datepicker as textfields input view.
    func showDateTime(sender: UITextField) {
        print ("magic")
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(DecisionViewController.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
        
        addTextField.inputView = SubCategoryDropDown
        
    }
    //This will update textfields text with value of datepicker.
    
    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm"
        
        //dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        
        dateTimeField.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    //Creates a add user label of type UILabel, addUserButton of type UIButton and add user field which is of type UITextField
    func addUsersLabel() {
        userLabel = UILabel(frame: CGRectMake(40, dateTimeField.frame.maxY+16, 240, 14))
        userLabel.textAlignment = NSTextAlignment.Center
        userLabel.text = "Add a user by username or email"
        userLabel.center.x = self.view.center.x
        userLabel.font=userLabel.font.fontWithSize(13)
        userLabel.textColor=UIColor.whiteColor()
        self.view.addSubview(userLabel)
    }
    
    func addUsersTB(z: CGFloat = 6){
        addUserField = UITextField(frame: CGRectMake(40, userLabel.frame.maxY+z, 240, 30))
        addUserField.backgroundColor = UIColor.whiteColor()
        addUserField.borderStyle = UITextBorderStyle.RoundedRect;
        addUserField.center.x = self.view.center.x
        self.view.addSubview(addUserField)
    }
    
    //creates an add button
    func addUsersButton(buttonWidth: CGFloat, buttonHeight: CGFloat)
    {
        plusButton = UIButton(frame: CGRect(x: buttonWidth, y: buttonHeight, width: 25, height: 25))
        plusButton.setBackgroundImage(UIImage(named: "PlusButton.png"), forState:UIControlState.Normal)
        self.view.addSubview(plusButton)
        plusButton.addTarget(self, action: "addUsersButton:", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    //button to add multilple users
    func addUsersButton (sender:UIButton!){
        j = j+30
        addUsersTB(j)
    }
    
    //validates the username or email entered by user in addUserField text field.
    func textFieldShouldReturn(_textField: UITextField!) -> Bool {
        var email: String = ""
        if let userEmail = addUserField.text{
            email = userEmail
        }
        
        //looks if the email entered exists in the database
        let userRef = ref.child("users");
        userRef.queryOrderedByChild("role").queryEqualToValue("User").observeEventType(.Value, withBlock: {
            snapshot in
            for child in snapshot.children {
                let uEmail = child.value["email"] as! String
                if (email == uEmail){
                    self.addUserField.layer.borderWidth = CGFloat(3.0)
                    self.addUserField.layer.borderColor = UIColor.greenColor().CGColor
                    self.usersList.append(self.addUserField.text!)
                         print (self.usersList)
                    return
                }
                else {
                    self.addUserField.layer.borderWidth = CGFloat(3.0)
                    self.addUserField.layer.borderColor = UIColor.redColor().CGColor
                    self.sendButton.enabled = false;
                }
            }
        })
        return true
    }
    
    //button to send the post to the users indicated by the user
    func send(){
        sendButton = UIButton(frame: CGRect(x: 40, y: addUserField.frame.maxY+50, width: 100, height: 40))
        sendButton.center.x = self.view.center.x
        sendButton.backgroundColor = UIColor.yellowColor()
        sendButton.setTitle("SEND", forState: UIControlState.Normal)
        sendButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.view.addSubview(sendButton)
        sendButton.addTarget(self, action: "sendPost:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    
    //writing data entered by user to firebase
    func sendPost(sender:UIButton!) {
        var category:String = ""
        category = CategoryTB.text!
        var message: String = ""
        message = messageField.text
        var postExpirationTime = dateTimeField.text
        let storageRef = FIRStorage.storage().reference()
        // var userID: String? = nil
        let user = FIRAuth.auth()?.currentUser
        
//        let post = ["category" : category,
//                    "Sub-category list" : subCategoryList,
//                    "Message" : message,
//                    "Post expiration time" : postExpirationTime,
//                    "Users" : usersList]
       
        ref.child("DecisionPost").child("category").setValue(category)
        ref.child("DecisionPost").child("Sub-category list").setValue(subCategoryList)
        ref.child("DecisionPost").child("Message").setValue(message)
        ref.child("DecisionPost").child("Post expiration time").setValue(postExpirationTime)
        ref.child("DecisionPost").child("Users").setValue(usersList)
        
//        self.performSegueWithIdentifier("ViewPostController", sender:self)
        
    }
}
