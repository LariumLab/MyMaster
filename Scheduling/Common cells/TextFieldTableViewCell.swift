//
//  TextFieldTableViewCell.swift
//  Scheduling
//
//  Created by macbook on 24.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    @IBOutlet weak var textField: UITextField!
    let cellHeight = CGFloat(44)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
