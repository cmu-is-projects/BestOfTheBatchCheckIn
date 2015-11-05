//
//  CheckInViewController.swift
//  BestOfTheBatchCheckIn
//
//  Created by Siddarth Sivakumar on 10/28/15.
//  Copyright © 2015 Siddarth Sivakumar. All rights reserved.
//

import UIKit
import AVFoundation

class CheckInViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var checkInButton: UIButton!

    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var lblDataInfo: UILabel!
    @IBAction func checkIn(sender: AnyObject) {
    }
    @IBAction func enterTicketNum(sender: AnyObject) {
        let alert = UIAlertController(title: "Enter Ticket Number", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Enter", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) in
            print(alert.textFields![0].text!)
            self.lblDataInfo.text = alert.textFields![0].text!
            self.checkInButton.enabled = true
        }))
        alert.addTextFieldWithConfigurationHandler{(textField) in
            textField.placeholder = "Ticket Number"
            textField.keyboardType = .NumberPad
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK: Properties
    let captureSession = AVCaptureSession()
    var captureDevice:AVCaptureDevice?
    var captureLayer:AVCaptureVideoPreviewLayer?
    
    let barcodeTypes = [AVMetadataObjectTypeUPCECode,
        AVMetadataObjectTypeCode39Code,
        AVMetadataObjectTypeCode39Mod43Code,
        AVMetadataObjectTypeEAN13Code,
        AVMetadataObjectTypeEAN8Code,
        AVMetadataObjectTypeCode93Code,
        AVMetadataObjectTypeCode128Code,
        AVMetadataObjectTypePDF417Code,
        AVMetadataObjectTypeQRCode,
        AVMetadataObjectTypeAztecCode
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCaptureSession()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        self.checkInButton.enabled = false
        lblDataInfo.text = "No Barcode Scanned"
//        self.setupCaptureSession()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Session Startup
    private func setupCaptureSession()
    {
        self.captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        let setupError:NSError?
        
        do {
            let deviceInput : AVCaptureDeviceInput = try AVCaptureDeviceInput(device: self.captureDevice) as AVCaptureDeviceInput!
            self.captureSession.addInput(deviceInput)
            self.setupPreviewLayer({
                self.captureSession.startRunning()
                self.addMetaDataCaptureOutToSession()
            })
        }catch let error as NSError {
            print(error)
            //            self.showError(setupError!.localizedDescription)
        }
        
    }
    
    private func setupPreviewLayer(completion:() -> ())
    {
        //        var captureLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.captureLayer = AVCaptureVideoPreviewLayer(session: self.captureSession) as? AVCaptureVideoPreviewLayer
        
        if let capLayer = self.captureLayer
        {
            capLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            capLayer.frame = self.cameraView.frame
            self.view.layer.addSublayer(capLayer)
            completion()
        }
        else
        {
            self.showError("An error occured beginning video capture.")
        }
    }
    
    //MARK: Metadata capture
    private func addMetaDataCaptureOutToSession()
    {
        let metadata = AVCaptureMetadataOutput()
        self.captureSession.addOutput(metadata)
        metadata.metadataObjectTypes = metadata.availableMetadataObjectTypes
        metadata.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
    }
    
    //MARK: Delegate Methods
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!)
    {
        for metaData in metadataObjects
        {
            if ((barcodeTypes.contains(metaData.type)) && metaData.isKindOfClass(AVMetadataMachineReadableCodeObject)){
                let decodedData:AVMetadataMachineReadableCodeObject = metaData as! AVMetadataMachineReadableCodeObject
                self.lblDataInfo.text = decodedData.stringValue
                self.checkInButton.enabled = true
            }
        }
    }
    
    //MARK: Utility Functions
    private func showError(error:String)
    {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .Alert)
        let dismiss:UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler:{(alert:UIAlertAction) in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        })
        alertController.addAction(dismiss)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //Prepare for segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "barcodeScanned" {
            let showWebpage:WebViewController = segue.destinationViewController as! WebViewController
            showWebpage.barcodeNum = self.lblDataInfo.text!
        }
    }

}
