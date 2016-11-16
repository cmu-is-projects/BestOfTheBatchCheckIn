//
//  WebViewController.swift
//  BestOfTheBatchCheckIn
//
//  Created by Aditi Sarkar on 11/1/15.
//  Copyright © 2015 Siddarth Sivakumar. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var barcodeNum: String = ""
    @IBOutlet weak var labelText: UILabel!
  
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        var url = NSURL(string: "")
        // print(barcodeNum)
        if (barcodeNum == "needToRegister"){
            url = NSURL(string: "http://inthepocket.org")
        }else if (barcodeNum == "needToAuthenticate"){
            url = NSURL(string: "http://inthepocket.org/login")
        }else {
            url = NSURL(string: "http://inthepocket.org/tickets/show_from_barcode/"+barcodeNum)
            // url = NSURL(string: "https://www.google.com")
        }
        // print("The URL is \(url!)")
        webView.loadRequest(NSURLRequest(URL: url!))
        labelText.text! = url!.absoluteString
        // print("Should have loaded resource")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
