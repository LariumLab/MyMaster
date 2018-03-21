//
//  ServiceCellInSalonProfileTableViewCell.swift
//  Scheduling
//
//  Created by macbook on 14.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class ServiceCellInSalonProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var ServicesNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setServicesNameLabel(name: String) {
        ServicesNameLabel.text = name
    }
    
}
