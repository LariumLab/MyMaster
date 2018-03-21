//
//  MasterAddServiceTableViewCell.swift
//  Scheduling
//
//  Created by macbook on 19.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class MasterCellInAddServiceTableViewCell: UITableViewCell {

    @IBOutlet weak var masterNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setMasterNameLabel(name: String) {
        masterNameLabel.text = name
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//    }
    
}
