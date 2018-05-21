//
//  SetWorkTimeForDayTableViewCell.swift
//  Scheduling
//
//  Created by macbook on 30.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class SetWorkTimeForDayTableViewCell: UITableViewCell {

    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var timeFromTextField: UITextField!
    @IBOutlet weak var timeToTextField: UITextField!
    @IBOutlet weak var colorView: UIView!
    
    @IBAction func timeFromAction(_ sender: UITextField) {
        setDatePicker(sender: sender)
    }
    
    @IBAction func timeToAction(_ sender: UITextField) {
        setDatePicker(sender: sender)
    }
    
    func setDatePicker(sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .time
        datePickerView.minuteInterval = 5
        datePickerView.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        datePickerView.timeZone = NSTimeZone(abbreviation: "GMT+0:00")! as TimeZone
        sender.inputView = datePickerView
        
        if sender == timeFromTextField {
            datePickerView.addTarget(self, action: #selector(timeFromDatePickerWasChanged(sender:)), for: .valueChanged)
        }
        else if sender == timeToTextField {
            datePickerView.addTarget(self, action: #selector(timeToDatePickerWasChanged(sender:)), for: .valueChanged)
        }
    }
    
    @objc func timeFromDatePickerWasChanged(sender: UIDatePicker) {
        let formatter = setDateFormatter()
        timeFromTextField.text = formatter.string(from: sender.date)
    }
    
    @objc func timeToDatePickerWasChanged(sender: UIDatePicker) {
        let formatter = setDateFormatter()
        timeToTextField.text = formatter.string(from: sender.date)
    }
    
    func setDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")! as TimeZone
        return dateFormatter
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
