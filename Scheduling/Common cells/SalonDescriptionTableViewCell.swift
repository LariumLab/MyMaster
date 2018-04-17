//
//  ProfileSalonDescriptionTableViewCell.swift
//  Scheduling
//
//  Created by macbook on 27.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class SalonDescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var organizationNameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var telephoneNumberLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var fullAdressButton: UIButton!
    let CellHeight = CGFloat(253)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
