//
//  WeekDescriptionTableViewCell.swift
//  Scheduling
//
//  Created by macbook on 21.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class WeekDescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var weekDateLabel: UILabel!
    let cellHeight = CGFloat(44)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
