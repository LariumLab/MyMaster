//
//  ProfileAddNewMasterTableViewController.swift
//  Scheduling
//
//  Created by macbook on 28.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class ProfileAddNewMasterTableViewController: UITableViewController {
    
    @objc func SaveMasterButton() {
        
        if (nameTextField.text?.isEmpty)! {
            let alertC = UIAlertController(title: "Ошибка при создании мастера", message: "Поле \"ФИО мастера\" не заполнено", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alertC.addAction(okAction)
            present(alertC, animated: true, completion: nil)
            return
        }
        
        if !(switchBoolVector[0] || switchBoolVector[1] || switchBoolVector[2] || switchBoolVector[3] || switchBoolVector[4] || switchBoolVector[5] || switchBoolVector[6]) {
            let alertC = UIAlertController(title: "Ошибка при создании мастера", message: "Все дни недели выбраны как нерабочие", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alertC.addAction(okAction)
            present(alertC, animated: true, completion: nil)
            return
        }
        
        let name : String = nameTextField.text!
        var schedule : [JSONDayInTable] = []
        
        var dayI = 0
        
        for day in weekDays {
            var startT = ""
            var endT = ""
            
            if switchBoolVector[dayI] {
                if segmentedControl.selectedSegmentIndex == 0 {
                    startT = startAndEndTextFields[0].0.text!
                    endT = startAndEndTextFields[0].1.text!
                }
                else {
                    startT = startAndEndTextFields[dayI].0.text!
                    endT = startAndEndTextFields[dayI].1.text!
                }
                
                if (startT.isEmpty || endT.isEmpty) {
                    let alertC = UIAlertController(title: "Ошибка при создании мастера", message: "Одно из полей \"время начала рабочего дня\" или \"время окончения рабочего дня\" не заполнено", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
                    alertC.addAction(okAction)
                    present(alertC, animated: true, completion: nil)
                    return
                }
            }
            
            let JSONDay = JSONDayInTable(name: day, isDayOff: switchBoolVector[dayI], startTime: startT, endTime: endT)
            schedule.append(JSONDay)
            dayI += 1
        }
        
        let createdMasterInfo = JSONMasterInfo(name: name, schedule: schedule)
        let data = try? JSONEncoder().encode(createdMasterInfo)
        let postMasterInfoURL =  serverAdr + "api/salon/addNewMaster?token=" + String(data: Keychain.load(key: "userToken")!, encoding: .utf8)!
        let URLPostMasterInfo = URL(string: postMasterInfoURL)
        guard ( URLPostMasterInfo != nil ) && ( data != nil ) else {
            return
        }
        
        var request = URLRequest(url: URLPostMasterInfo!)
        request.httpMethod = "POST"
        request.httpBody = data
        //===
        print(String(data: data!, encoding: .utf8)!)
        //===
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            print("RESPONSE")
            print(response ?? "response")
        }
        task.resume()
        
        //        let task = URLSession.shared.dataTask(with: request)
        //        task.resume()
        
        //        print(name)
        //        for i in schedule {
        //            print(i.name)
        //            print(i.startTime + "  " + i.endTime)
        //        }
        
    }
    
    var nameTextField = UITextField()
    var startAndEndTextFields : [(UITextField, UITextField)] = []
    
    //    var currentServce = Service()
    var masterName = ""
    var salonID = UUID()
    
    let weekDays = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    
    var switchBoolVector = [ Bool(true), Bool(true), Bool(true), Bool(true), Bool(true), Bool(false), Bool(false)]
    var positionsOfTrueInSwitchBoolVector : [Int] = []
    
    func updatePositionsOfTrueInSwitchBoolVector() {
        positionsOfTrueInSwitchBoolVector = []
        for i in 0...switchBoolVector.count - 1 {
            if switchBoolVector[i] == true {
                positionsOfTrueInSwitchBoolVector.append(i)
            }
        }
    }
    
    var segmentedCell = SegmentedControlTableViewCell()
    var segmentedControl = UISegmentedControl()
    
    let textFieldCellIdentifier = "AddMasterNameCell"
    let switchCellIdentifier = "AddMasterSwitchCell"
    let segmentedCellIdentifier = "AddMasterSegmentedCell"
    let standartWorkDayCellIdentifier = "AddMasterStandartDayCell"
    let differentWorkDayCellIdentiier = "AddMasterDifferentDayCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let createMasterButton = UIBarButtonItem(title: "Создать", style: .done, target: self, action: #selector(SaveMasterButton))
        navigationItem.rightBarButtonItem = createMasterButton
        
        tableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: textFieldCellIdentifier)
        tableView.register(UINib(nibName: "NameWithSwitchTableViewCell", bundle: nil), forCellReuseIdentifier: switchCellIdentifier)
        tableView.register(UINib(nibName: "SegmentedControlTableViewCell",bundle: nil), forCellReuseIdentifier: segmentedCellIdentifier)
        tableView.register(UINib(nibName: "SetTimeOfWorkDayTableViewCell", bundle: nil), forCellReuseIdentifier: standartWorkDayCellIdentifier)
        tableView.register(UINib(nibName: "SetWorkTimeForDayTableViewCell", bundle: nil), forCellReuseIdentifier: differentWorkDayCellIdentiier)
        
        segmentedCell = tableView.dequeueReusableCell(withIdentifier: segmentedCellIdentifier, for: IndexPath(row: 0, section: 2)) as! SegmentedControlTableViewCell
        segmentedControl = segmentedCell.segmentedControlOutlet
        segmentedControl.setTitle("Универсальный р/день", forSegmentAt: 0)
        segmentedControl.setTitle("Разные р/дни", forSegmentAt: 1)
        segmentedControl.addTarget(self, action: #selector(ProfileAddNewMasterTableViewController.segmentedControlValueChanged), for: .valueChanged)
        updatePositionsOfTrueInSwitchBoolVector()
    }
    
    @objc func nameWasChanged() {
        masterName = nameTextField.text!
    }
    
    @objc func segmentedControlValueChanged() {
        startAndEndTextFields = []
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0, 2:
            return 1
        case 1:
            return weekDays.count
        case 3:
            if segmentedControl.selectedSegmentIndex == 0 { return 1 }
            else { return positionsOfTrueInSwitchBoolVector.count }
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "ФИО мастера"
        case 1:
            return "Рабочие дни"
        case 2:
            return "Время рабочего дня"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if segmentedControl.selectedSegmentIndex == 1 && indexPath.section == 3 {
            return 84
        }
        else { return 44 }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.text = masterName
            nameTextField = cell.textField
            nameTextField.addTarget(self, action: #selector(nameWasChanged), for: .editingDidEnd)
            
            let gamma = blueGamma()
            gamma.makeViewStyle(view: cell.textField, color: gamma.whiteColor, radius: 5)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: switchCellIdentifier, for: indexPath) as! NameWithSwitchTableViewCell
            cell.nameLabel.text = weekDays[indexPath.row]
            cell.switchOutlet.isOn = switchBoolVector[indexPath.row]
            cell.switchOutlet.onTintColor = blueGamma().mediumBlue
            cell.cellOwnerVC = self
            cell.cellNumberInSection = indexPath.row
            return cell
        case 2:
            //            segmentedCell.segmentedControlOutlet.backgroundColor = blueGamma().skyBlue
            segmentedCell.segmentedControlOutlet.tintColor = blueGamma().mediumBlue
            return segmentedCell
        case 3:
            
            if segmentedControl.selectedSegmentIndex == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: standartWorkDayCellIdentifier, for: indexPath) as! SetTimeOfWorkDayTableViewCell
                let gamma = blueGamma()
                gamma.makeViewStyle(view: cell.leftTextField, color: gamma.whiteColor, radius: 5)
                gamma.makeViewStyle(view: cell.rightTextField, color: gamma.whiteColor, radius: 5)
                cell.leftTextField.text = ""
                cell.rightTextField.text = ""
                startAndEndTextFields.append( (cell.leftTextField, cell.rightTextField) )
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: differentWorkDayCellIdentiier, for: indexPath) as! SetWorkTimeForDayTableViewCell
                cell.dayNameLabel.text = weekDays[positionsOfTrueInSwitchBoolVector[indexPath.row]]
                let gamma = blueGamma()
                gamma.makeViewStyle(view: cell.timeFromTextField, color: gamma.whiteColor, radius: 5)
                gamma.makeViewStyle(view: cell.timeToTextField, color: gamma.whiteColor, radius: 5)
                gamma.makeViewStyle(view: cell.colorView, color: gamma.biegeColor, radius: 5)
                cell.timeFromTextField.text = ""
                cell.timeToTextField.text = ""
                startAndEndTextFields.append( (cell.timeFromTextField, cell.timeToTextField) )
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
}
