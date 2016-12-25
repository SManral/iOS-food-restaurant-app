//
//  MenuPicker.swift
//  Paladar
//
//  Created by sasa cocic on 10/22/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import Firebase

class MenuPicker: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var menus = (menuNames: [String](),menuKeys: [String]())
    var currentUser : String? = nil
    var pickedRow : (name : String?,key: String?)

    @IBOutlet weak var menuPicker: UIPickerView!{
        didSet{
            self.menuPicker.delegate = self
            self.menuPicker.dataSource = self
            getMenus()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return menus.menuNames.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return menus.menuKeys[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedRow = (menus.menuNames[row], menus.menuKeys[row])
    }
    
    private func getMenus(){
        var db = FIRDatabase.database().reference()
        db.child("/users/\(currentUser!)/Menus").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            if let values = snapshot.value as? [String : String]{
                for (key,value) in values{
                    self.menus.menuKeys.append(value)
                    self.menus.menuNames.append(key)
                }
            }
            dispatch_async(dispatch_get_main_queue(), { 
                self.menuPicker.reloadAllComponents()
                self.pickedRow = (self.menus.menuNames[0],self.menus.menuKeys[0])
            })
            
        })
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //returnToDinnerParty
        
//        if let identifier = segue.identifier{
//            let db = FIRDatabase.database().reference()
//            switch identifier {
        
//        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
