//
//  SidebarMainViewController.swift
//  Paladar
//
//  Created by Smriti Manral on 10/2/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//
import UIKit
import CoreLocation
import SWRevealViewController
import Firebase

class SidebarMainViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager:CLLocationManager!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var currLocation: UILabel!
    @IBOutlet weak var locationImg: UIImageView!
    var recommendations = [(item: String,price: String, from: String)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRecommendations()
        
        /**
         displays users current location on the homepage by requesting user to enable location services
         This uses Standard location service to get users current location
         The standard location service is a configurable, general-purpose solution for getting location data and tracking location changes for the specified level of accuracy.
         **/
        manager = CLLocationManager()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.manager.distanceFilter  = 5000 // Must move at least 5km
            manager.desiredAccuracy = kCLLocationAccuracyKilometer
            manager.startUpdatingLocation()
        }
        /**
         for the slide out menu button lets user toggle the slide out menu button and displays menu items from the SideMenuController using SWRevealViewConroller
         **/
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = Selector("revealToggle:")
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    /**
     getting latitude and longitude of users location
     
     
     Converting geogrpahic coordinated to locations through reverse geocoding
     A geocoder object uses a network service to convert between latitude and longitude values and a user-friendly placemark, which is a collection of data such as the street, city, state, and country information. Reverse geocoding is the process of converting a latitude and longitude into a placemark; forward geocoding is the process of converting place name information into latitude and longitude values.
     **/
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [CLLocation]){
        let userLocation = locations[0] //gets current most recent location
        let longitude = userLocation.coordinate.longitude;
        let latitude = userLocation.coordinate.latitude;
        let lastLocation: CLLocation = locations[locations.count - 1];
        manager.stopUpdatingLocation();
        var placemark: CLPlacemark!
        //The result (i.e. the address) returned by CLGeocoder is saved in a CLPlacemark object.
        var location=CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(userLocation) {(placemarks, error)->Void in
            if (error != nil) {
                print(error);
            }
            else{
                if let placeMarks = placemarks as [CLPlacemark]!{
                    let p:CLPlacemark = placeMarks[0]
                    var subLocality:String = ""
                    var thoroughfare:String = ""
                    var administrativeArea:String = ""
                    var postalCode:String = ""
                    var country:String = ""
                    
                    
                    //city
                    if p.subLocality != nil{
                        subLocality = p.subLocality!
                    }
                    //street number, name
                    if p.thoroughfare != nil{
                        thoroughfare = p.thoroughfare!
                    }
                    //state
                    if p.administrativeArea != nil{
                        administrativeArea = p.administrativeArea!
                    }
                    //postal code
                    if p.postalCode != nil{
                        postalCode = p.postalCode!
                    }
                    //country
                    if p.country != nil{
                        country = p.country!
                    }
                    self.currLocation.text = "\(subLocality),\(administrativeArea)";
                    
                }
            }
        }
    }
    
    
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        print("Error while updating location " + error.localizedDescription)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if let identifier = segue.identifier {
            
            switch identifier {
            case "dinnerPartySegue":
                if let vc = segue.destinationViewController as? DiningOptionsController{
                    
                }
            case "recommendationPicker":
                if let vc = segue.destinationViewController as? RecommendationViewController{
                    vc.recommendations = self.recommendations
                }
            default:
                print("no identifier found")
            }
        }
        
    }
    
    
    func getRecommendations(){
        FIRDatabase.database().reference().child("recommendations/\(FIRAuth.auth()!.currentUser!.uid)").observeSingleEventOfType(.Value) { (snapshot,error) in
            
            if(error != nil){
                return
            }
            
            let calendar = NSCalendar.currentCalendar()
            
            let df = NSDateFormatter()
            df.dateFormat = "MM-dd-yyyy HH:mm"
            
            if let vals = snapshot.value as? [String : String]{
                //can be case this is jsut a temporary check
            }
            else{
                return
            }
            
            for (key,value) in snapshot.value as! [String : String]{
                
                
                let dateAndPaymentUser = key.componentsSeparatedByString("*")
                
                let date = df.dateFromString(dateAndPaymentUser[0])
                
                let date1 = calendar.startOfDayForDate(date!)
                let date2 = calendar.startOfDayForDate(NSDate())
                
                let flags = NSCalendarUnit.Day
                let components = calendar.components(flags, fromDate: date1, toDate: date2, options: [])
                if(components.day == 1){
                    let mealAndPrice = value.componentsSeparatedByString("*")
                    self.recommendations.append((mealAndPrice[0],mealAndPrice[1],dateAndPaymentUser[1]))
                }
                
            }
            //TODO recommendations don't handle multipule users
            dispatch_async(dispatch_get_main_queue(), {
                var orders = ""
                var z = 0
                while(z < self.recommendations.count-1){
                    orders.appendContentsOf("\(self.recommendations[z].item),")
                    z+=1
                }
                if(self.recommendations.count != 0){
                    orders.appendContentsOf(self.recommendations.last!.item)//if empty this could cause a problem
                    
                    let alertController = UIAlertController(title: "Recommendation", message:
                        "yesterday you ordered \(orders) would you like to have any of these orders again?", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    alertController.addAction(UIAlertAction(title: "order again", style: UIAlertActionStyle.Default, handler: { (alert) in
                        
                        self.performSegueWithIdentifier("recommendationPicker", sender: nil)
                        
                    }))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                }
                
            })
        }
    }
    
    func daysBetweenDates(startDate: NSDate, endDate: NSDate) -> Int
    {
        let calendar = NSCalendar.currentCalendar()
        
        let components = calendar.components([.Day], fromDate: startDate, toDate: endDate, options: [])
        
        return components.day
    }
    
    
    @IBAction func returnToHome(segue : UIStoryboardSegue){
        
        
        
    }
    
    
}
