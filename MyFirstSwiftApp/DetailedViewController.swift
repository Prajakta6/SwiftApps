//
//  DetailedViewController.swift
//  MyFirstSwiftApp
//
//  Created by Prajakta Shinde on 4/25/18.
//  Copyright © 2018 Prajakta Shinde. All rights reserved.
//
import Foundation
import UIKit
import CoreData
import Alamofire
import MessageUI

class DetailedViewController: UIViewController, MFMailComposeViewControllerDelegate {

    
    @IBOutlet weak var resultLabel: UILabel!
   
    var userData: UserData?
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var empidTextField: UITextField!
    
    @IBOutlet weak var desgTextField: UITextField!
    
    
    let url = URL(string:  "https://reqres.in/api/users")!
    
    //var user: [NSManagedObject] = []
    var users  = [User]()
    
    var responseDataDictionary = [AnyHashable:Any]()
    var responseDataArray = [UserModel]()
   
    
    /*
    @IBOutlet weak var nameDataLabel: UILabel!
    
    @IBAction func getDataButton(_ sender: Any)
    {
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "User")
        
        //3
        do {
            users = try managedContext.fetch(fetchRequest) as! [User]
            
            for item in users
            {
                print("Database values are Name \(item.name), Email \(item.email) Username \(item.username) Password \(item.password)")
                
            }
            
           nameDataLabel.text = users[1].name
            
           self.performSegue(withIdentifier: "tableVC", sender:responseDataArray )
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
 */
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title="Details"
        
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        
        // resultLabel.text = String(responseDataArray.count)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitDataClicked(_ sender: Any)
    {
        PostAPICall()
    }
   
    func PostAPICall()
    {
        Alamofire.request("https://reqres.in/api/users", method: .post, parameters: ["name" : self.nameTextField.text as Any, "empid" : self.empidTextField.text as Any , "desg" : self.desgTextField.text as Any]).responseJSON { response in
            switch response.result {
            case .success:
                print("Validation Successful")
            case .failure(let error):
                print(error)
            }
            
            if let json = response.result.value {
                print("JSON: \(json)")
            }
        }
        
        self.performSegue(withIdentifier: "tableVC", sender:responseDataArray )
    }
    
    @IBAction func goToExpandableTView(_ sender: Any)
    {
        self.performSegue(withIdentifier: "expandableVC", sender: nil )
    }
   
    @IBAction func sendEmailButtonClicked(_ sender: Any)
    {
        var csvString = NSMutableString()
        csvString.appendFormat("%-12@","Show Code, ")
        csvString.appendFormat("%-12@","Scan Value, ")
        csvString.appendFormat("%-12@","Scan Date, ")
        csvString.appendFormat("%-12@","Notes, ")
        csvString.appendFormat("%-12@","Rank, ")
        csvString.appendFormat("%-12@","Event Name, ")
        csvString.appendFormat("%-12@","Event State, ")
        csvString.appendFormat("%-12@","Event Location, ")
        csvString.appendFormat("%-12@","Event Start Date, ")
        csvString.appendFormat("%-12@","Event End Date, ")
        
        csvString.append("\n")
        csvString.appendFormat("%-12@","ABCDEF, ")
         csvString.appendFormat("%-12@","7864253, ")
         csvString.appendFormat("%-12@","7th June 2018, ")
         csvString.appendFormat("%-12@","this is testing, ")
         csvString.appendFormat("%-12@","1,")
         csvString.appendFormat("%-12@","B'day party, ")
         csvString.appendFormat("%-12@","MH, ")
         csvString.appendFormat("%-12@","Pune IT Park, ")
         csvString.appendFormat("%-12@","17th June 2018, ")
         csvString.appendFormat("%-12@","18th June 2018, ")
        
        
        var testString = NSString()
        
        testString = String(format: "%@%x", csvString) as NSString
        
        // Creating a string.
        var mailString = NSMutableString()
        mailString.append("Column A, Column B\n")
        mailString.append("Row 1 Column A, Row 1 Column B\n")
        mailString.append("Row 2 Column A, Row 2 Column B\n")
        
        // Converting it to NSData.
        let data = mailString.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false)
        
        // Unwrapping the optional.
        if let content = data {
            print("NSData: \(content)")
        }
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.setToRecipients(["prajakta.shinde@silicus.com"])
        composeVC.setSubject("GTCF Leads Log")
        composeVC.setMessageBody("Hey Prajakta! Here's my feedback.", isHTML: false)
        
       // composeVC.addAttachmentData(data!, mimeType: "text/csv", fileName: "Sample.csv")
        
        var finalData = NSData()

        finalData = csvString.data(using: String.Encoding.utf8.rawValue,allowLossyConversion: false) as! NSData

         composeVC.addAttachmentData(finalData as Data, mimeType: "text/csv", fileName: "leadslognew.csv")
        
//        if let filePath = Bundle.main.path(forResource: "swifts", ofType: "wav") {
//            print("File path loaded.")
//
//            if let fileData = NSData(contentsOfFile: filePath) {
//                print("File data loaded.")
//                composeVC.addAttachmentData(fileData as Data, mimeType: "audio/wav", fileName: "swifts")
//            }
//        }
//
//        let imageData: NSData = (UIImageJPEGRepresentation(imgView.image!, 0.5) as? NSData)!
//        composeVC.addAttachmentData(imageData as Data, mimeType: "image/jpeg", fileName: "image.jpg")
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                                 didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }

    //    @IBAction func okBtnClicked(_ sender: Any)
//    {
//        self.performSegue(withIdentifier: "tableVC", sender:responseDataArray )
//    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (segue.identifier == "tableVC")
        {
            let thirdViewController = segue.destination as! TableViewViewController

            thirdViewController.dataArray =  (sender as? [UserModel])!
        }
        if(segue.identifier == "expandableVC")
        {
            let ExpandableTVViewController = segue.destination as! ExpandableTVViewController          
        }
    }   

}
