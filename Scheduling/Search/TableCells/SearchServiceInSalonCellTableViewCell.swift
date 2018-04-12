//
//  SearchServiceInSalonCellTableViewCell.swift
//  Scheduling
//
//  Created by macbook on 11.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class SearchServiceInSalonCellTableViewCell: UITableViewCell {
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var priceToLabel: UILabel!
    @IBOutlet weak var priceFromLabel: UILabel!
    let cellHeight = CGFloat(128)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
