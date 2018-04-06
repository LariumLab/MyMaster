//
//  ProfileAddNewMasterTableViewController.swift
//  Scheduling
//
//  Created by macbook on 28.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class ProfileAddNewMasterTableViewController: UITableViewController {

//    var currentServce = Service()
    var currentMaster = Master()
    
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
 // Спросить про Selector. stackoverflow сказал, что надо добавить перед функцией @objc, но почему?
    @objc func segmentedControlValueChanged() {
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
            cell.textField.text = currentMaster.name
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: switchCellIdentifier, for: indexPath) as! NameWithSwitchTableViewCell
            cell.nameLabel.text = weekDays[indexPath.row]
            cell.switchOutlet.isOn = switchBoolVector[indexPath.row]
            cell.cellOwnerVC = self
            cell.cellNumberInSection = indexPath.row
            return cell
        case 2:
            return segmentedCell
        case 3:
            
            if segmentedControl.selectedSegmentIndex == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: standartWorkDayCellIdentifier, for: indexPath) as! SetTimeOfWorkDayTableViewCell
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: differentWorkDayCellIdentiier, for: indexPath) as! SetWorkTimeForDayTableViewCell
                cell.dayNameLabel.text = weekDays[positionsOfTrueInSwitchBoolVector[indexPath.row]]
                return cell
            }
        default:
        return UITableViewCell()
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
