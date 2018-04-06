//
//  SegmentedControlTableViewCell.swift
//  Scheduling
//
//  Created by macbook on 30.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class SegmentedControlTableViewCell: UITableViewCell {

    @IBOutlet weak var segmentedControlOutlet: UISegmentedControl!
    
    func setSegmentedControlNames(left: String, right: String){
        segmentedControlOutlet.setTitle(left, forSegmentAt: 0)
        segmentedControlOutlet.setTitle(right, forSegmentAt: 1)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
