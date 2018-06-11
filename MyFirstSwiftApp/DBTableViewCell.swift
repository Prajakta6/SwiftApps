//
//  DBTableViewCell.swift
//  MyFirstSwiftApp
//
//  Created by Prajakta Shinde on 5/23/18.
//  Copyright © 2018 Prajakta Shinde. All rights reserved.
//

import UIKit

class DBTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var dbNameLabel: UILabel!
    
    @IBOutlet weak var dbEmailLabel: UILabel!
    
    @IBOutlet weak var dbUsernameLabel: UILabel!
    
    @IBOutlet weak var dbPasswordLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
