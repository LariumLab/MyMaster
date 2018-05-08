//
//  ClientAppointmentTableViewCell.swift
//  Scheduling
//
//  Created by macbook on 10.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class ClientAppointmentTableViewCell: UITableViewCell {

    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var salonNameLabel: UILabel!
    @IBOutlet weak var salonAdressLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
//    let CellHeigh = CGFloat(157)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
