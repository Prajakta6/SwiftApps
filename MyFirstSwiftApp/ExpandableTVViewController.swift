//
//  ExpandableTVViewController.swift
//  MyFirstSwiftApp
//
//  Created by Prajakta Shinde on 5/31/18.
//  Copyright © 2018 Prajakta Shinde. All rights reserved.
//

import UIKit

class ExpandableTVViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var expandableTableView: UITableView!
    
    var expandData = [NSMutableDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.expandableTableView.isEditing = true
        
        self.expandData.append(["isOpen":"0","data":["banana","mango"]])
        self.expandData.append(["isOpen":"0","data":["banana","mango","apple"]])
        self.expandData.append(["isOpen":"0","data":["banana"]])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.expandData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.expandData[section].value(forKey: "isOpen") as! String == "1"{
            return 0
        }else{
            let dataarray = self.expandData[section].value(forKey: "data") as! NSArray
            return dataarray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:ExpandableTableViewCell = tableView.dequeueReusableCell(withIdentifier: "expandableViewCell") as! ExpandableTableViewCell
        cell.selectionStyle = .blue
        let dataarray = self.expandData[indexPath.section].value(forKey: "data") as! NSArray
        cell.expandLbl.text = dataarray[indexPath.row] as? String
        return cell
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = UIColor.gray
        let label = UILabel(frame: CGRect(x: 5, y: 3, width: headerView.frame.size.width - 5, height: 27))
        label.text = "\(section)"
        headerView.addSubview(label)
        headerView.tag = section + 100
        
        let tapgesture = UITapGestureRecognizer(target: self , action: #selector(self.sectionTapped(_:)))
        headerView.addGestureRecognizer(tapgesture)
        return headerView
    }
    @objc func sectionTapped(_ sender: UITapGestureRecognizer){
        if(self.expandData[(sender.view?.tag)! - 100].value(forKey: "isOpen") as! String == "1"){
            self.expandData[(sender.view?.tag)! - 100].setValue("0", forKey: "isOpen")
        }else{
            self.expandData[(sender.view?.tag)! - 100].setValue("1", forKey: "isOpen")
        }
        self.expandableTableView.reloadSections(IndexSet(integer: (sender.view?.tag)! - 100), with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete
        {
        print("Section is: \(indexPath.section) and Row is: \(indexPath.row)" )

        let currentDictionary = self.expandData[indexPath.section]

        let selectedIndexArray = currentDictionary.value(forKey: "data")

        var dataArray  = Array<Any>()

        dataArray = selectedIndexArray as! [Any]
        dataArray.remove(at: indexPath.row)

        self.expandData.remove(at: indexPath.section)
        self.expandData.insert(["isOpen":"0","data":dataArray], at: indexPath.section)

        self.expandableTableView.reloadData()
        }
    }

    // MARK: - Reordering
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let movedObject = self.expandData[sourceIndexPath.row]
        expandData.remove(at: sourceIndexPath.row)
        expandData.insert(movedObject, at: destinationIndexPath.row)
        NSLog("%@", "\(sourceIndexPath.row) => \(destinationIndexPath.row) \(expandData)")
        // To check for correctness enable: self.tableView.reloadData()
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
