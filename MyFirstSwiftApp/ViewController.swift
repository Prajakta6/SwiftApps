//
//  ViewController.swift
//  MyFirstSwiftApp
//
//  Created by Prajakta Shinde on 4/13/18.
//  Copyright © 2018 Prajakta Shinde. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{

    @IBOutlet weak var dbTableView: UITableView!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    var userEnteredData: UserData?
    
   // var names: [String] = []
    var user: [NSManagedObject] = []
     var usersData  = [User]()
      var resultArray = [UserModel]()
    //var responseDictionary:Dictionary<String,String>
 
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title="Register"
        
        passwordField.isSecureTextEntry = true
        
        nameField.text="Prajakta"
        emailField.text="prajakta.shinde@silicus.com"
        usernameField.text="pshinde"
        passwordField.text="pshinde"
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitButtonClicked(_ sender: UIButton)
    {
        guard let name = nameField.text, name != "" else{
            showAlert(alertMessage: "Name field is empty")
            return
        }
        
        
        guard let email = emailField.text, email != "" else {
            showAlert(alertMessage: "Email field is empty")
            return
        }
        
        guard  let uname = usernameField.text, uname != "" else {
            showAlert(alertMessage: "Username field is empty")
            return
        }
        
        guard let pwd = passwordField.text,pwd != "" else {
            
            showAlert(alertMessage: "Password field is empty")
            return
        }
     
        //add nameField Text to names string array
        // self.names.append(name)
        self.save(name: name, email: email, username: uname, password: pwd)
       
        let manager = NetworkReachabilityManager(host: "www.apple.com")
        
        manager?.listener = { status in
            print("Network Status Changed: \(status)")
            //self.showAlert(alertMessage: "Connected to: \(status)")
        }
        manager?.startListening()
      
        self.APICallWith(requestFor: "employees") { (status,responce) in
            
            if (status)
            {
               // print("responseString = \(responce ?? "No record")")
                
//                print("User entered data is: Name: \(name) Email: \(email) Username: \(uname) Password: \(pwd)")
//
                
                let myarray = responce as? Array<Any>
                for item in myarray!
                {
                    print(item)
                    
                  //responce is from server
                    var responseDictionary = item as! Dictionary<AnyHashable,String>
                    
                    let userModel = UserModel()
                    userModel.id = responseDictionary["id"]
                    userModel.employee_name = responseDictionary["employee_name"]
                    userModel.employee_age = responseDictionary["employee_age"]
                    userModel.employee_salary = responseDictionary["employee_salary"]
                    userModel.profile_image = responseDictionary["profile_image"]
                    
                   self.resultArray.append(userModel)                   
                    
                }
                
                self.userEnteredData = UserData.init(id: 1, name: name, email: email, username: uname, password: pwd)
                
//                self.performSegue(withIdentifier: "detailVC", sender: self.userEnteredData)
                
//                self.performSegue(withIdentifier: "detailVC", sender: responseDictionary)
                
               /* working   self.performSegue(withIdentifier: "detailVC", sender: resultArray) */

                

//                if let data = newResult.data(using: String.Encoding.utf8)
//                {
//                    do {
//                        dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
//
//                        if let myDictionary = dictonary
//                        {
//                            print(" First name is: \(myDictionary["first_name"]!)")
//                        }
//                    } catch let error as NSError {
//                        print(error)
//                    }
//                }
            }
        }
        
        self.getData()
        
        self.dbTableView.reloadData()
        
      
    }

    func save(name: String, email: String, username: String, password: String)
    {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "User",
                                       in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        person.setValue(name, forKeyPath: "name")
        person.setValue(email, forKeyPath: "email")
        person.setValue(username, forKeyPath: "username")
        person.setValue(password, forKeyPath: "password")
        
        // 4
        do {
            try managedContext.save()
            user.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func getData()
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
            usersData = try managedContext.fetch(fetchRequest) as! [User]
            
            for item in usersData
            {
                print("Database values are Name \(item.name), Email \(item.email) Username \(item.username) Password \(item.password)")
            }
            
        }
        catch let error as NSError
        {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    let baseURL = "http://dummy.restapiexample.com/api/v1/"
    
   // func APICallWith(requestFor:String, withCompletionHandler Success:@escaping ((_ status:Bool)->Void)) {
    
    //API call to GET the data
    func APICallWith(requestFor:String, withCompletionHandler Success:@escaping ((_ status:Bool, _ responce:Any?)->Void))
    {
            // Define server side script URL
            let scriptUrl = baseURL
            // Create NSURL Ibject
            let myUrl = NSURL(string: scriptUrl.appending(requestFor));

            print("URL: \(myUrl!)")
            // Creaste URL Request
            let request = NSMutableURLRequest(url:myUrl! as URL);
            
            // Set request HTTP method to GET. It could be POST as well
            request.httpMethod = "GET"
            
           // request.addValue(token, forHTTPHeaderField: "Token")
        
        
            // Excute HTTP Request
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                //To keep the UI unfrozen and responsive to the user actions use  DispatchQueue.main.async
                DispatchQueue.main.async {
             
                // Check for error
                if error != nil
                {
                    print("error=\(String(describing: error))")
                   Success(false,nil)
                    return
                }
                
                    let httpResponse = response as! HTTPURLResponse
                    
                    print("Code: \(httpResponse.statusCode)")
                    
                    if(httpResponse.statusCode==200)  {
                     //
                    }
                // Print out response string
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    
                // Convert server json response to NSDictionary
                do {
                   
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options:.mutableContainers) as? NSArray {
                        
                        if(convertedJsonIntoDict.count>0){
                            
                           Success(true,convertedJsonIntoDict)
                        }
                    }
                    } catch let error as NSError {
                        print(error.localizedDescription)}
               }
            }
            
            task.resume()
    }
    
    func showAlert(alertMessage:String)->Void //func with parameter
    {
        let alertController = UIAlertController(title: "Alert", message: alertMessage, preferredStyle:UIAlertControllerStyle.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("you have pressed OK button");
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return usersData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:DBTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DBCustomCell") as! DBTableViewCell
        cell.selectionStyle = .blue
        
        if (usersData.count) ?? 0 > 0
        {
            let person = usersData[indexPath.row]
            cell.dbNameLabel.text = person.name
            cell.dbEmailLabel.text = person.email
            cell.dbUsernameLabel.text = person.username
            cell.dbPasswordLabel.text = person.password
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        self.performSegue(withIdentifier: "detailVC", sender: resultArray)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "detailVC")
        {
            let secondViewController = segue.destination as! DetailedViewController            
//            secondViewController.responseDataDictionary = (sender as? Dictionary<AnyHashable,Any>)!
             secondViewController.responseDataArray = (sender as? [UserModel])!
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let userEntity = "User" //Entity Name
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let note = usersData[indexPath.row]
        
        if editingStyle == .delete {
            managedContext.delete(note)
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Error While Deleting Note: \(error.userInfo)")
            }            
        }
        
        //Code to Fetch New Data From The DB and Reload Table.
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: userEntity)
        
        do {
            usersData = try managedContext.fetch(fetchRequest) as! [User]
        } catch let error as NSError {
            print("Error While Fetching Data From DB: \(error.userInfo)")
        }
        self.dbTableView.reloadData()
    }

}


