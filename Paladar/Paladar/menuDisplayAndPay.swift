//
//  menuDisplayAndPay.swift
//  Paladar
//
//  Created by sasa cocic on 10/23/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import Firebase

class menuDisplayAndPay: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: properties
    
    var userId : String? = nil
    var menu = [[String]]()
    
    @IBOutlet weak var itemsPickedLabel: UILabel!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    var items = [(item: String, price: String)]()

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            getMenu()
        }
    }
    
    // MARK : lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK : Delegate methods
    
    //how many sections are in the table view
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return menu.count
    }
    //how many rows are in each section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu[section].count
    }
    //what to display for that row in that section
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell
        if indexPath.row == 0{
            cell = tableView.dequeueReusableCellWithIdentifier("titleCell", forIndexPath: indexPath)
            cell.textLabel?.text! = menu[indexPath.section][indexPath.row]
        }
        else{
            cell = tableView.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath)
            if let c =  cell as? menuCell{
                c.name.text! = menu[indexPath.section][indexPath.row]
            }
            
        }
        
        return cell
    }
    
    // MARK: Actions
    
    //add and remove things from the picked and total price labels
    @IBAction func addAndRemoveItems(sender: UIButton) {
        
        let view = sender.superview!
        let cell = view.superview
        if let mpCell = cell as? menuCell{
            let ip = tableView.indexPathForCell(mpCell)
            let data = menu[ip!.section][ip!.row]
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
            totalPriceLabel.text! = String(format:"%.2f", totalPrice)
        }
    }
    
    // MARK: DB
    
    //Gets all of the menus from the user that was clicked on and displays all of the food from all of their menus
    private func getMenu(){
        
        let db = FIRDatabase.database().reference()
        db.child("/users/\(userId!)/Menus").observeSingleEventOfType(.Value) { (snapshot, error) in
            if(snapshot.childrenCount != 0){
                for (userMenuKeys, _) in snapshot.value as! [String : String]{
                    db.child("Menus/\(userMenuKeys)").observeSingleEventOfType(.Value, withBlock: { (snap) in
                        for (menuSection, menuRows) in snap.value as! [String : AnyObject]{
                            //things in the menu
                            var menuSectionAndRow = [String]()//what is this name?? change it
                            menuSectionAndRow.append(menuSection)
                            for (menuRowKey,menuRowValue) in menuRows as! [String : String]{
                                menuSectionAndRow.append("\(menuRowKey) \(menuRowValue)")
                            }
                            self.menu.append(menuSectionAndRow)
                        }
                        dispatch_async(dispatch_get_main_queue(), {
                            self.tableView.reloadData()
                        })
                    })
                }
            }
        }
        
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier{
            
            switch identifier {
            case "orderCheckout":
                if let vc = segue.destinationViewController as? CheckoutController {
                    vc.paymentToUser = userId
                    if(items.count == 1){//means they only wanted one thing
                        vc.checkoutItem = (items[0].item,items[0].price)
                    }
                    
                }
            default:
                print("no segue identifier found")
            }
            
        }
    }
 

}
