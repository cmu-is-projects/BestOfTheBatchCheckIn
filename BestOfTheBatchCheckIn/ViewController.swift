//
//  ViewController.swift
//  BestOfTheBatchCheckIn
//
//  Created by Siddarth Sivakumar on 10/25/15.
//  Copyright © 2015 Siddarth Sivakumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "registerSegue" {
            let showWebpage:WebViewController = segue.destinationViewController as! WebViewController
            showWebpage.barcodeNum = "needToRegister"
        }
    }


}

