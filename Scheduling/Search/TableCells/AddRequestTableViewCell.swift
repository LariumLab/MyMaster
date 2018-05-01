//
//  AddRequestTableViewCell.swift
//  Scheduling
//
//  Created by macbook on 25.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class AddRequestTableViewCell: UITableViewCell, UITextViewDelegate, UITextFieldDelegate {
    
    var descriptionTextViewWasTapped = false
    var tableView = UITableView()
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBAction func sendRequestAction(_ sender: Any) {
    }
    
    func load(){
//        OperationQueue.main.addOperation {
            self.tableView.beginUpdates()
            self.descriptionTextView.text = "Введите описание к запросу, которое, по Вашему мнению, может помочь салону определить длительность и стоимость услуги."
//            self.descriptionTextView.sizeToFit()
//            self.descriptionTextView.layoutIfNeeded()
//            self.updateConstraints()
            self.tableView.endUpdates()
//        }
        
        let currentDate = Date()
        let calendar = Calendar.current
        descriptionTextView.textColor = UIColor.lightGray
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.delegate = self
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(sender:)), for: .valueChanged)
        datePicker.minimumDate = currentDate
        datePicker.maximumDate = calendar.date(byAdding: .month, value: 4, to: currentDate)
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.timeZone = NSTimeZone(abbreviation: "GMT+0:00")! as TimeZone
        timePicker.minuteInterval = 5
        timePicker.addTarget(self, action: #selector(self.timePickerValueChanged(sender:)), for: .valueChanged)
        timePicker.locale = Locale(identifier: "en_GB")
        
        dateTextField.inputView = datePicker
        timeTextField.inputView = timePicker
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        dateTextField.text = formatter.string(from: sender.date)
    }
    
    @objc func timePickerValueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")! as TimeZone
        timeTextField.text = formatter.string(from: sender.date)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if descriptionTextViewWasTapped == false {
            tableView.beginUpdates()
            descriptionTextView.text = ""
            descriptionTextViewWasTapped = true
            descriptionTextView.textColor = UIColor.black
            tableView.endUpdates()
        }
        tableView.beginUpdates()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        tableView.endUpdates()
    }
    
    func textViewDidChange(_ textView: UITextView) {
//        updateConstrainfts()
        layoutIfNeeded()
        tableView.endUpdates()
        tableView.beginUpdates()
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
