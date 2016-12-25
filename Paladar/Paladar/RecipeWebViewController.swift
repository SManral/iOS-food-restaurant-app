//
//  RecipeWebViewController.swift
//  Paladar
//
//  Created by Smriti Manral on 11/11/16.
//  Copyright © 2016 SasaCorp. All rights reserved.
//

import UIKit

class RecipeWebViewController: UIViewController {

    @IBOutlet var WebView: UIWebView!
    var sourceUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print (sourceUrl)
        let url = NSURL (string: sourceUrl);
        let requestObj = NSURLRequest(URL: url!);
        WebView.loadRequest(requestObj);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
