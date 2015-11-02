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
    
    var webView: WKWebView!
    var barcodeNum: String = ""
    
    override func loadView() {
        super.loadView()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var url = NSURL(string: "")
        print(barcodeNum)
        if (barcodeNum == "needToRegister"){
            url = NSURL(string: "https://www.cnn.com")
        }else {
            url = NSURL(string: "https://www.cmu.edu")
//            let url = NSURL(string: "https://inthepocket.org/tickets/show_from_barcode/"+barcodeNum)
        }
        print(url)
        webView.loadRequest(NSURLRequest(URL: url!))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
