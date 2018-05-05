//
//  SalonRequestTableViewCell.swift
//  Scheduling
//
//  Created by macbook on 23.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class SalonRequestTableViewCell: UITableViewCell {
    @IBOutlet weak var headColourView: UIView!
    @IBOutlet weak var colourView: UIView!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var clientNumberLabel: UILabel!
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var masterNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func MakeEffects() {
        headColourView.layer.cornerRadius = 15
        colourView.layer.cornerRadius = 15
        colourView.layer.shadowRadius = 5
        colourView.layer.shadowOpacity = 0.3
        colourView.layer.shadowOffset = CGSize.zero
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
