//
//  MapViewController.swift
//  Paladar
//
//  Created by sasa cocic on 9/12/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import GoogleMaps
import FirebaseAuth

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.cameraWithLatitude(-33.86, longitude: 151.20, zoom: 6.0)
        self.mapView.myLocationEnabled = true
        self.mapView.camera = camera
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = self.mapView
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Logout() {
        do {
            try FIRAuth.auth()?.signOut()
        }
        catch{
            print("there was an error")
        }
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let next = storyBoard.instantiateViewControllerWithIdentifier("signIn")
        self.presentViewController(next, animated: true, completion: nil)
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
