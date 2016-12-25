//
//  CheckoutController.swift
//  Paladar
//
//  Created by sasa cocic on 9/26/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//
import UIKit
import Braintree
import Firebase

class CheckoutController: UIViewController, BTDropInViewControllerDelegate {
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var checkoutItem : (item: String?, price: String?)
    var recommendationPayment = false
    var paymentToUser : String?
    
    var braintreeClient: BTAPIClient?
    //var CLIENT_AUTHORIZATION : String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = Selector("revealToggle:")
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        let clientTokenURL = NSURL(string: "http://localhost:3000/")!
        let clientTokenRequest = NSMutableURLRequest(URL: clientTokenURL)
        clientTokenRequest.setValue("text/plain", forHTTPHeaderField: "Accept")
        
        NSURLSession.sharedSession().dataTaskWithRequest(clientTokenRequest) { (data, response, error) -> Void in
            // TODO: Handle errors
            let clientToken = String(data: data!, encoding: NSUTF8StringEncoding)
            
            self.braintreeClient = BTAPIClient(authorization: clientToken!)
            // As an example, you may wish to present our Drop-in UI at this point.
            // Continue to the next section to learn more...
            }.resume()
    }
    
    @IBAction func checkout() { tappedMyPayButton() }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tappedMyPayButton() {
        
        // If you haven't already, create and retain a `BTAPIClient` instance with a
        // tokenization key OR a client token from your server.
        // Typically, you only need to do this once per session.
        // braintreeClient = BTAPIClient(authorization: CLIENT_AUTHORIZATION)
        
        // Create a BTDropInViewController
        let dropInViewController = BTDropInViewController(APIClient: braintreeClient!)
        dropInViewController.delegate = self
        
        // This is where you might want to customize your view controller (see below)
        
        // The way you present your BTDropInViewController instance is up to you.
        // In this example, we wrap it in a new, modally-presented navigation controller:
        dropInViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonSystemItem.Cancel,
            target: self, action: #selector(CheckoutController.userDidCancelPayment))
        let navigationController = UINavigationController(rootViewController: dropInViewController)
        presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func userDidCancelPayment() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dropInViewController(viewController: BTDropInViewController,
                              didSucceedWithTokenization paymentMethodNonce: BTPaymentMethodNonce)
    {
        // Send payment method nonce to your server for processing
        postNonceToServer(paymentMethodNonce.nonce)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dropInViewControllerDidCancel(viewController: BTDropInViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func postNonceToServer(paymentMethodNonce: String) {
        let paymentURL = NSURL(string: "http://localhost:3000/checkouts")!
        let request = NSMutableURLRequest(URL: paymentURL)
        request.HTTPBody = "payment_method_nonce=\(paymentMethodNonce)".dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPMethod = "POST"
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            // TODO: Handle success or failure
            
            //do this if there is no error
            
            if(error == nil){
                let df = NSDateFormatter()
                df.dateFormat = "MM-dd-yyyy HH:mm"
                let str = df.stringFromDate(NSDate())
                
//                let serverResponose = String(data: data!, encoding: NSUTF8StringEncoding)
                
                let trimmedItemString = self.checkoutItem.item!.stringByTrimmingCharactersInSet(
                    NSCharacterSet.whitespaceAndNewlineCharacterSet()
                )
                
                FIRDatabase.database().reference().child("recommendations/\(FIRAuth.auth()!.currentUser!.uid)/\(str)*\(self.paymentToUser!)").setValue("\(trimmedItemString)*\(self.checkoutItem.price!)")
            }
            else{
                print(error)
            }
            
            
            
            
            }.resume()
    }
    
    
    
}


