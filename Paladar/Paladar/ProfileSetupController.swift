//
//  ProfileSetupController.swift
//  Paladar
//
//  Created by sasa cocic on 10/4/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit
import Firebase

class ProfileSetupController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    // CODE NEEDS MAJOR REFACTORING ******
    
    // MARK: - Properties

    @IBOutlet weak var imageInView: UIImageView!
    @IBOutlet weak var profileDescription: UITextField!
    var userId: String? = nil
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userId = FIRAuth.auth()!.currentUser!.uid
        imageInView.image = UIImage(named: "cy")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Profile Logic
    
    @IBAction func uploadPicture(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        presentViewController(picker, animated: true, completion: nil)
    }
    
    
    @IBAction func makePic() {
        
        let thing = FIRDatabase.database().reference().child("users/\(self.userId!)/profileImageURL")
        thing.removeAllObservers()
        
        
        let sb = self.storyboard
        let vc = sb?.instantiateViewControllerWithIdentifier("signIn") as! LoginViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
        
        /*
        //This code is used to read from the DB
         
         
        let thing = FIRDatabase.database().reference().child("users/\(self.userId!)/profileImageURL")
        
        thing.observeSingleEventOfType(.Value, withBlock: { snapshot in
            let url = snapshot.value as! String
            
            let urlString = NSURL(string: url)
            
            NSURLSession.sharedSession().dataTaskWithURL(urlString!) { (data, response, error) in
                if error != nil {
                    print(error)
                    return
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.imageInView?.image = UIImage(data: data!)
                })
                }.resume()
        })
         */
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        var selectedImage: UIImage?
        
        if let editedPicture = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImage = editedPicture
        }
        else if let originalPicture = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = originalPicture
        }
        imageInView?.contentMode = .ScaleAspectFit
        imageInView?.clipsToBounds = true
        imageInView.image = selectedImage!
        
        
        let imageName = NSUUID().UUIDString
        let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).png")
        let uploadData = UIImagePNGRepresentation(selectedImage!)
        
        storageRef.putData(uploadData!, metadata: nil) { (metadata, error) in
            if(error != nil){
                print(error)
            }
            else{
                print(metadata!.downloadURL()?.absoluteString)
                let db = FIRDatabase.database().reference()
                db.child("users/\(self.userId!)/profileImageURL").setValue(metadata!.downloadURL()!.absoluteString)
                db.child("users/\(self.userId!)/description").setValue(self.profileDescription.text!)
            }
            
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
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
