//
//  ScheduleTimeTableViewCell.swift
//  Scheduling
//
//  Created by macbook on 14.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class ScheduleTimeTableViewCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    let CellHeight = CGFloat(60)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
