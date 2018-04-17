//
//  SetTimeOfWorkDayTableViewCell.swift
//  Scheduling
//
//  Created by macbook on 30.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class SetTimeOfWorkDayTableViewCell: UITableViewCell {

    @IBOutlet weak var leftTextField: UITextField!
    @IBOutlet weak var rightTextField: UITextField!
    
    func setTextFieldFromDatePicker(datePicker: UIDatePicker, textField: UITextField){
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        dateFormatter.dateFormat = "HH:mm"
        textField.text = dateFormatter.string(from: datePicker.date)
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
