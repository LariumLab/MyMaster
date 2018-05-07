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
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var telephoneNumberLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var fullAdressLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    //    let CellHeight = CGFloat(253)
    
//    func MakeEffects(color: UIColor, radius: CGFloat) {
//        colorView.backgroundColor = color
//        colorView.layer.cornerRadius = radius
//        colorView.layer.shadowRadius = 5
//        colorView.layer.shadowOpacity = 0.3
//        colorView.layer.shadowOffset = CGSize.zero
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
