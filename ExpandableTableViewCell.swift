//
//  ExpandableTableViewCell.swift
//  MyFirstSwiftApp
//
//  Created by Prajakta Shinde on 5/31/18.
//  Copyright © 2018 Prajakta Shinde. All rights reserved.
//

import UIKit

class ExpandableTableViewCell: UITableViewCell {

    @IBOutlet weak var expandLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
