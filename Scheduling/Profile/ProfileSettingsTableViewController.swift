//
//  ProfileSettingsTableViewController.swift
//  Scheduling
//
//  Created by macbook on 09.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class ProfileSettingsTableViewController: UITableViewController {
    
    var profile = Profile()

    let textFieldCellIdentifier = "SettingsTextFieldCell"
    let descriptionCellIdentifier = "SettingsDescriptionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Настройки"
        tableView.tableFooterView = UIView()
        
        tableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: textFieldCellIdentifier)
        tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: descriptionCellIdentifier)
        
        if profileType == true {
            profile = salon
        }
        else {
            profile = client
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if profileType == true { return 6 }
        else { return 2 }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            if profileType == true { return "Имя салона" }
            else{ return "Имя" }
        case 1:
            return "Номер телефона"
        case 2:
            return "Никнейм"
        case 3:
            return "Описание салона"
        case 4:
            return "Город"
        case 5:
            return "Полный адрес"
        default:
            return " "
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 3:
            let DescriptionCell = DescriptionTableViewCell()
            return DescriptionCell.CellHeigh
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.text = profile.name
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.text = profile.phoneNumber
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            let SettingsOfSalon = profile as! Salon
            cell.textField.text = SettingsOfSalon.nickname
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: descriptionCellIdentifier, for: indexPath) as! DescriptionTableViewCell
            let SettingsOfSalon = profile as! Salon
            cell.descriptionTextView.text = SettingsOfSalon.description
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            let SettingsOfSalon = profile as! Salon
            cell.textField.text = SettingsOfSalon.city
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell

            let SettingsOfSalon = profile as! Salon
            cell.textField.text = SettingsOfSalon.adress
            return cell
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
