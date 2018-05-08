//
//  ProfileClientTableViewCell.swift
//  Scheduling
//
//  Created by macbook on 10.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class ProfileClientDescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var listLabel: UILabel!
    
//    let CellHeigh = CGFloat(114)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
