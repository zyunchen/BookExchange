//
//  AddBookWithScannerViewController.swift
//  BookExchange
//
//  Created by zhangyunchen on 16/4/23.
//  Copyright © 2016年 zhangyunchen. All rights reserved.
//

import UIKit
import TFBarcodeScanner

class AddBookWithScannerViewController: TFBarcodeScannerViewController {
    
    var barcodeString:String?
    
    

    @IBAction func didCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barcodeTypes = TFBarcodeType.EAN8.rawValue | TFBarcodeType.EAN13.rawValue | TFBarcodeType.UPCA.rawValue | TFBarcodeType.UPCE.rawValue | TFBarcodeType.QRCODE.rawValue
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowAddBookDetail" {
            let addBookViewController = segue.destinationViewController as! AddBookDetailViewController
            addBookViewController.isbn = barcodeString
        }
    }
    
    //MARK: TFBarcodeScannerViewController
    override func barcodePreviewWillShowWithDuration(duration: CGFloat) {

    }

    override func barcodePreviewWillHideWithDuration(duration: CGFloat) {

    }

    override func barcodeWasScanned(barcodes: Set<NSObject>!) {
        self.stop()
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        for barcode in barcodes {
            let barcode = barcode as! TFBarcode
            print("scanned bar code is " + barcode.string)
            barcodeString = barcode.string
            performSegueWithIdentifier("ShowAddBookDetail", sender: self)
        }
    }
}
