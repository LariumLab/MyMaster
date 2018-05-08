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
    let exitCellIdentifier = "ExitCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Настройки"
        tableView.tableFooterView = UIView()
        
        tableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: textFieldCellIdentifier)
        tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: descriptionCellIdentifier)
        tableView.register(UINib(nibName: "NameLabelTableViewCell", bundle: nil), forCellReuseIdentifier: exitCellIdentifier)
        
        switch profileType! {
        case .salon:
            profile = salon
        case .client:
            profile = client
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if profileType == ProfileType.salon { return 7 }
        else if profileType == ProfileType.client { return 3 }
        else { return 0 }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            if profileType == ProfileType.salon { return "Имя салона" }
            else if profileType == ProfileType.client { return "Имя" }
            else { return " " }
        case 1:
            return "Номер телефона"
        case 2:
            if profileType == ProfileType.salon { return "Никнейм" }
            else if profileType == ProfileType.client { return "Выход" }
            else { return " " }
        case 3:
            return "Описание салона"
        case 4:
            return "Город"
        case 5:
            return "Полный адрес"
        case 6:
            return "Выход"
        default:
            return " "
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 3:
            let DescriptionCell = DescriptionTableViewCell()
            return DescriptionCell.CellHeight
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let gamma = blueGamma()
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.text = profile.name
            gamma.makeViewStyle(view: cell.textField, color: gamma.whiteColor, radius: 5)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.text = profile.phoneNumber
            gamma.makeViewStyle(view: cell.textField, color: gamma.whiteColor, radius: 5)
            return cell
        case 2:
            if profileType == ProfileType.salon {
                let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
                let SettingsOfSalon = profile as! Salon
                cell.textField.text = SettingsOfSalon.nickname
                gamma.makeViewStyle(view: cell.textField, color: gamma.whiteColor, radius: 5)
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: exitCellIdentifier, for: indexPath) as! NameLabelTableViewCell
                cell.nameLabel.textAlignment = .center
                cell.nameLabel.text = "Выйти из аккаунта"
                cell.nameLabel.textColor = UIColor(red:0.50, green:0.00, blue:0.00, alpha:1.0)
                return cell
            }
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: descriptionCellIdentifier, for: indexPath) as! DescriptionTableViewCell
            let SettingsOfSalon = profile as! Salon
            cell.descriptionTextView.text = SettingsOfSalon.description
            gamma.makeViewStyle(view: cell.descriptionTextView, color: gamma.whiteColor, radius: 5)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            let SettingsOfSalon = profile as! Salon
            cell.textField.text = SettingsOfSalon.city
            gamma.makeViewStyle(view: cell.textField, color: gamma.whiteColor, radius: 5)
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell

            let SettingsOfSalon = profile as! Salon
            cell.textField.text = SettingsOfSalon.adress
            gamma.makeViewStyle(view: cell.textField, color: gamma.whiteColor, radius: 5)
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: exitCellIdentifier, for: indexPath) as! NameLabelTableViewCell
            cell.nameLabel.textAlignment = .center
            cell.nameLabel.text = "Выйти из аккаунта"
            cell.nameLabel.textColor = UIColor(red:0.50, green:0.00, blue:0.00, alpha:1.0)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 6) || (indexPath.section == 2 && profileType == ProfileType.client){
            
            let alertC = UIAlertController(title: "Подтвердите действие", message: "Вы уверены, что хотите выйти из аккаунта?", preferredStyle: .alert)
            let OkAction = UIAlertAction(title: "Выход", style: .destructive) { (alert) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginNavigationC = storyboard.instantiateViewController(withIdentifier: "LoginNavigationC") as! UINavigationController
                let tabBar = storyboard.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
                
                //        self.dismiss(animated: true, completion: nil)
                // ВНИМАНИЕ: после добавления проверки токена заменить present на dismiss
                
                self.present(loginNavigationC, animated: true, completion: nil)
                tabBar.viewControllers?.removeLast() // отсается только поиск
            }
    
            let CancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            alertC.addAction(OkAction)
            alertC.addAction(CancelAction)
            present(alertC, animated: true, completion: nil)
        }
    }
}
