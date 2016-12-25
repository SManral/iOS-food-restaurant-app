//
//  DinnerPartyInfoController.swift
//  Paladar
//
//  Created by sasa cocic on 10/26/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import Firebase

class DinnerPartyInfoController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var menuId : String? = nil
    var menuItems = [[String]]()
    var items = [(item: String, price: String)]()

    @IBOutlet weak var itemsPickedLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{ tableView.delegate = self; tableView.dataSource = self; }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = FIRDatabase.database().reference()
        print(menuId!)
        
        db.child("Menus/\(menuId!)").observeSingleEventOfType(.Value) { (snap,err) in
            
            for (key, value) in snap.value as! [String : AnyObject]{
                var arr = [String]()
                print("\(key)")
                arr.append(key)
                for (k,v) in value as! [String : String]{
                    arr.append("\(k)  \(v)")
                }
                self.menuItems.append(arr)
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
                
            
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addItem(sender: UIButton) {
        
        let view = sender.superview!
        let cell = view.superview
        if let mpCell = cell as? menuPayCell{
            let ip = tableView.indexPathForCell(mpCell)
            let data = menuItems[ip!.section][ip!.row]
            var allItems = ""
            var totalPrice = 0.0
            let itemAndPrice = data.componentsSeparatedByString("$")
            if sender.titleLabel!.text! == "Add"{
                items.append((itemAndPrice[0],itemAndPrice[1]))
            }
            else{
                for (a,b) in items.enumerate(){
                    if itemAndPrice[0] == b.item{
                        items.removeAtIndex(a)
                        break
                    }
                }
            }
            for (food,price) in items{
                allItems.appendContentsOf("\(food) ")
                let p = Double(price)
                totalPrice += p!
            }
            
            itemsPickedLabel.text! = allItems
            totalLabel.text! = String(format:"%.2f", totalPrice)
        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        print(menuItems.count)
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(menuItems[section].count)
        return menuItems[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell
        if indexPath.row == 0{
            cell = tableView.dequeueReusableCellWithIdentifier("titleCell", forIndexPath: indexPath)
            cell.textLabel?.text! = menuItems[indexPath.section][indexPath.row]
        }
        else{
            cell = tableView.dequeueReusableCellWithIdentifier("mCell", forIndexPath: indexPath)
            if let c =  cell as? menuPayCell{
                c.label.text! = menuItems[indexPath.section][indexPath.row]
            }
            
        }
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
