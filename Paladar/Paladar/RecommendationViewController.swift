//
//  RecommendationViewController.swift
//  Paladar
//
//  Created by sasa cocic on 11/23/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import Firebase

class RecommendationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var recommendations = [(item: String, price: String, from: String)]()

    @IBOutlet weak var recommendationPicker: UIPickerView!{
        didSet{
            recommendationPicker.delegate = self
            recommendationPicker.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserFrom()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return recommendations.count
    }
    
    /*
     Asks for the specific data in the row and coulmn
     */
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(recommendations[row].item) $\(recommendations[row].price)-\(recommendations[row].from)"
    }
    
    
    func getUserFrom(){
        
        for (idx,tuple) in recommendations.enumerate() {
            FIRDatabase.database().reference().child("users/\(tuple.from)").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                
                let username = snapshot.childSnapshotForPath("username").value as! String
                self.recommendations[idx].from = username
                dispatch_async(dispatch_get_main_queue(), {
                    self.recommendationPicker.reloadAllComponents()
                })
            })
        }
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // MARK: - Actions
    
    @IBAction func mealPickedAndGoToPayment() {
        
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewControllerWithIdentifier("checkoutVC") as! CheckoutController
        vc.recommendationPayment = true
        let curRow = recommendationPicker.selectedRowInComponent(0)
        vc.checkoutItem = (recommendations[curRow].item, recommendations[curRow].price)
        vc.paymentToUser = recommendations[curRow].from
        
        self.presentViewController(vc, animated: true, completion: nil)

        //self.navigationController?.pushViewController(vc, animated:true)
    }

}
