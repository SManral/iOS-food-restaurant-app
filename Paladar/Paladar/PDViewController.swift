//
//  PDViewController.swift
//  Paladar
//
//  Created by zhengf on 10/5/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import Foundation
import UIKit

class PDViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
   @IBOutlet weak var collectionView: UICollectionView!
    let meal = ["Sea Food", "Chef's Recommendations", "House Speical Dishes", "Rice Dishes"]
    let imageArray = [UIImage(named: "Beef"),UIImage(named: "Burger"),UIImage(named: "Chicken"),UIImage(named: "Chinese")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.meal.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCellPD
        
        cell.imageView?.image = self.imageArray[indexPath.row]
        cell.Label?.text = self.meal[indexPath.row]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showImage", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showImage"{
            let indexPaths = self.collectionView!.indexPathsForSelectedItems()!
            let indexPath = indexPaths[0] as NSIndexPath
            let vc = segue.destinationViewController as! NewViewController
            vc.image = self.imageArray[indexPath.row]!
            vc.title = self.meal[indexPath.row]
    }
}
}
