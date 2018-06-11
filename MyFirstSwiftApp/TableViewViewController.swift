//
//  TableViewViewController.swift
//  MyFirstSwiftApp
//
//  Created by Prajakta Shinde on 4/26/18.
//  Copyright © 2018 Prajakta Shinde. All rights reserved.
//

import UIKit

class TableViewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    
    var dataArray = [UserModel]()
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var salaryLabel: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 120;
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomTableViewCell
        cell.selectionStyle = .blue
        let model:UserModel = dataArray [indexPath.row]
        cell.nameLabel.text = model.employee_name
        cell.ageLabel.text = model.employee_age
        cell.salaryLabel?.text = model.employee_salary
        cell.profileImage?.image = UIImage(named: "Image\(arc4random_uniform(3) + 1).png")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       
        self.performSegue(withIdentifier: "tabVC",sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "tabVC")
        {
            let tabBar = segue.destination as! TabViewController
            
        }
    }
   

}
