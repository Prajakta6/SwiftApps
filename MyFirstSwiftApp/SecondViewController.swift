//
//  SecondViewController.swift
//  MyFirstSwiftApp
//
//  Created by Prajakta Shinde on 4/26/18.
//  Copyright © 2018 Prajakta Shinde. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
     @objc var items : NSArray = [UIImage(named:"Image1.png")!,UIImage(named:"Image2.png")!,UIImage(named:"Image3.png")!,UIImage(named:"Image4.png")!,UIImage(named:"Image5.png")!,UIImage(named:"Image6.png")!,UIImage(named:"Image7.png")!,UIImage(named:"Image8.png")!]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return items.count * 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let identifier: String = "CollectionCell"
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = items.object(at: (indexPath as NSIndexPath).row%8) as? UIImage
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Collection View controller"

        // Do any additional setup after loading the view.
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
