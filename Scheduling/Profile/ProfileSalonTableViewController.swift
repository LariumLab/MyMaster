//
//  ProfileSalonTableViewController.swift
//  Scheduling
//
//  Created by macbook on 27.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class ProfileSalonTableViewController: UITableViewController {
    
    var registeredSalon = Salon() // Загрузка, load data
    
    let DescriptionCellIdentifier = "SalonDescriptionCell"
    let ListAndAddCellIdentifier = "ProfileSalonListAndAddCell"
    let ServiceCellIdentifier = "ProfileSalonServiceCell"
    
    @objc func SettingsButtonSelected(){
        let SettingsVC = UIStoryboard.init(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileSettings") as! ProfileSettingsTableViewController
        SettingsVC.profile = registeredSalon
        self.navigationController?.pushViewController(SettingsVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registeredSalon = salon
        
        tableView.register(UINib(nibName: "SalonDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: DescriptionCellIdentifier)
        tableView.register(UINib(nibName: "ListAndAddTableViewCell", bundle: nil), forCellReuseIdentifier: ListAndAddCellIdentifier)
        tableView.register(UINib(nibName: "NameWithDisclosureIndicatorTableViewCell", bundle: nil), forCellReuseIdentifier: ServiceCellIdentifier)
        self.navigationItem.title = registeredSalon.nickname
        self.tabBarController?.title = "Профиль"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Настройки", style: .done, target: self, action: #selector(SettingsButtonSelected))
        
        let backBarButton = UIBarButtonItem(title: "Профиль", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + registeredSalon.services.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
//            let ProfileSalonCell = SalonDescriptionTableViewCell()
//            return ProfileSalonCell.CellHeight
            return UITableViewAutomaticDimension
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCellIdentifier, for: indexPath) as! SalonDescriptionTableViewCell
            cell.organizationNameLabel.text = registeredSalon.name
            cell.organizationNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
            let attributes = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 17)]
            let AttributedDescr = NSMutableAttributedString(string: "Описание: ", attributes: attributes)
            AttributedDescr.append(NSAttributedString(string: registeredSalon.description))
            cell.descriptionLabel.attributedText = AttributedDescr
//            cell.descriptionLabel.text = "Описание: " + registeredSalon.description
            let AttributedPhoneNumber = NSMutableAttributedString(string: "Телефон: ", attributes: attributes)
            AttributedPhoneNumber.append(NSAttributedString(string: registeredSalon.phoneNumber ))
            cell.telephoneNumberLabel.attributedText = AttributedPhoneNumber
//            cell.telephoneNumberLabel.text = "Телефон: " + registeredSalon.phoneNumber
            let AttributedCity = NSMutableAttributedString(string: "Город: ", attributes: attributes)
            AttributedCity.append(NSAttributedString(string: registeredSalon.city))
            cell.cityLabel.attributedText = AttributedCity
//            cell.cityLabel.text = "Город: " + registeredSalon.city
            let AttributedAdress = NSMutableAttributedString(string: "Полный адрес: ", attributes: attributes)
            AttributedAdress.append(NSAttributedString(string: registeredSalon.adress))
            cell.fullAdressLabel.attributedText = AttributedAdress
//            cell.fullAdressLabel.text = "Полный адрес: " + registeredSalon.adress
//            cell.MakeEffects(color: blueGamma().biegeColor, radius: 10)
            let gamma = blueGamma()
            gamma.makeViewStyle(view: cell.colorView, color: gamma.biegeColor, radius: 10)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ListAndAddCellIdentifier, for: indexPath) as! ListAndAddTableViewCell
            cell.initialize(functionType: .addService, currentTableVC: self, listName: "Услуги:")
            cell.listNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
//            cell.MakeEffects(viewColor: blueGamma().skyBlue, addButtonColor: blueGamma().darkBlue, radius: 10)
//            cell.colorView.layer.borderColor = UIColor.lightGray.cgColor
//            cell.colorView.layer.borderWidth = 1
            let gamma = blueGamma()
            gamma.makeViewStyle(view: cell.colorView, color: gamma.skyBlue, radius: 10)
            cell.addButton.tintColor = gamma.darkBlue
            return cell
        case 2...(registeredSalon.services.count + 2):
            let cell = tableView.dequeueReusableCell(withIdentifier: ServiceCellIdentifier, for: indexPath) as! NameWithDisclosureIndicatorTableViewCell
            cell.nameLabel.text = registeredSalon.services[indexPath.row-2].name
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row >= 2 {
            let addNewServiceVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileAddService") as! ProfileAddNewServiceTableViewController
            addNewServiceVC.creatingService = registeredSalon.services[indexPath.row-2]
            self.navigationController?.pushViewController(addNewServiceVC, animated: true)
        }
    }
}
