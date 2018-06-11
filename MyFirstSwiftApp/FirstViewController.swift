//
//  FirstViewController.swift
//  MyFirstSwiftApp
//
//  Created by Prajakta Shinde on 4/26/18.
//  Copyright © 2018 Prajakta Shinde. All rights reserved.
//

import UIKit
import MediaPlayer
import MobileCoreServices

class FirstViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Camera View"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takePhotoClicked(_ sender: Any)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        
        //to select only camera controls, not video
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.showsCameraControls = true
        //imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageData = UIImagePNGRepresentation(image)! as Data
        
        //        //save in photo album
        //        UIImageWriteToSavedPhotosAlbum(image, self, Selector(("image:didFinishSavingWithError:contextInfo:")), nil)
        //
        //        //save in documents
        //        let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
        //        let filePath = (documentsPath! as NSString).appendingPathComponent("pic.png")
        //        try? imageData.write(to: URL(fileURLWithPath: filePath), options: [.atomic])
        
        imageView.image = image
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: NSErrorPointer?, contextInfo: UnsafeRawPointer){
        if(error != nil){
            print("ERROR IMAGE \(error.debugDescription)")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        self.dismiss(animated: true, completion: nil)
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
