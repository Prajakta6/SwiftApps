//
//  BarcodeScannarViewController.swift
//  MyFirstSwiftApp
//
//  Created by Prajakta Shinde on 6/6/18.
//  Copyright © 2018 Prajakta Shinde. All rights reserved.
//

import UIKit
import BarcodeScanner

class BarcodeScannarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewController = makeBarcodeScannerViewController()
        viewController.title = "Barcode Scanner"
       // present(viewController, animated: true, completion: nil)
        
         navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func makeBarcodeScannerViewController() -> BarcodeScannerViewController {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        return viewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - BarcodeScannerCodeDelegate

extension BarcodeScannarViewController: BarcodeScannerCodeDelegate {
    public func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print("Barcode Data: \(code)")
        print("Symbology Type: \(type)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            controller.reset()
        }
    }
}

// MARK: - BarcodeScannerErrorDelegate

extension BarcodeScannarViewController: BarcodeScannerErrorDelegate {
    public func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
}

// MARK: - BarcodeScannerDismissalDelegate

extension BarcodeScannarViewController: BarcodeScannerDismissalDelegate {
    public func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
