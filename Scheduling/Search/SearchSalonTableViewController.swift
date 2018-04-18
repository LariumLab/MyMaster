//
//  SearchSalonTableViewController.swift
//  Scheduling
//
//  Created by macbook on 11.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class SearchSalonTableViewController: UITableViewController {

    var currentSalon : Salon = Salon()
    let salonDescriptionCellIdentifier = "SearchSalonDescriptionCell"
    let serviceCellIdentifier = "SearchServiceInListCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentSalon = TestSalon1 // загрузка
        
        tableView.register(UINib(nibName: "SalonDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: salonDescriptionCellIdentifier)
        tableView.register(UINib(nibName: "SearchServiceInSalonCellTableViewCell", bundle: nil), forCellReuseIdentifier: serviceCellIdentifier)
        self.navigationItem.title = currentSalon.nickname
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let ServiceVC = UIStoryboard.init(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchServiceInSalon") as! SearchServiceInSalonTableViewController
            // ЗАГРУЗКА -> GetService(salon: Salon, index: Int)
            let selectedService = currentSalon.services[indexPath.row]
            ServiceVC.service = selectedService
            self.navigationController?.pushViewController(ServiceVC, animated: true)
        }
        

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        case 1:
            return "Услуги:"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return currentSalon.services.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            let SalonDescCell = SalonDescriptionTableViewCell()
            return SalonDescCell.CellHeight
        case 1:
            let ServiceCell = SearchServiceInSalonCellTableViewCell()
            return ServiceCell.cellHeight
        default:
            return 44
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: salonDescriptionCellIdentifier, for: indexPath) as! SalonDescriptionTableViewCell
            cell.organizationNameLabel.text = currentSalon.name
            cell.descriptionTextView.text = currentSalon.description
            cell.telephoneNumberLabel.text = currentSalon.phoneNumber
            cell.cityLabel.text = currentSalon.city
            cell.fullAdressButton.titleLabel?.text = currentSalon.adress
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: serviceCellIdentifier, for: indexPath) as! SearchServiceInSalonCellTableViewCell
            cell.serviceNameLabel.text = currentSalon.services[indexPath.row].name
            cell.priceFromLabel.text = currentSalon.services[indexPath.row].priceFrom
            cell.priceToLabel.text = currentSalon.services[indexPath.row].priceTo
            return cell
        default:
            return UITableViewCell()
        }
    }
}
