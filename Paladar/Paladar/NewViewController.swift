//
//  NewViewController.swift
//  Paladar
//
//  Created by zhengf on 10/5/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import Social

class NewViewController: UIViewController{
    @IBOutlet weak var imageView: UIImageView!
    
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = self.image
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareToFacebook(){
        let shareToFacebook: SLComposeViewController = SLComposeViewController(forServiceType:SLServiceTypeFacebook)
        self.presentViewController(shareToFacebook, animated: true, completion: nil)
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
