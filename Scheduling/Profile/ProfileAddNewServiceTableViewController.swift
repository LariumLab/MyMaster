//
//  AddNewServiceTableViewController.swift
//  Scheduling
//
//  Created by macbook on 24.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class ProfileAddNewServiceTableViewController: UITableViewController {

    var creatingService = Service()
    
    let serviceNameCellIdentifier = "AddServiceNameCell"
    let serviceDescriptionCellIdentifier = "AddServiceDescriptionCell"
    let servicePriceCellIdentifier = "AddServicePriceCell"
    let serviceListNameCellIdentifier = "AddServiceListNameCell"
    let serviceMasterInListCellIdentifier = "AddServiceMasterInListCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: serviceNameCellIdentifier)
        tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: serviceDescriptionCellIdentifier)
        tableView.register(UINib(nibName: "PriceTableViewCell", bundle: nil), forCellReuseIdentifier: servicePriceCellIdentifier)
        tableView.register(UINib(nibName: "ListAndAddTableViewCell", bundle: nil), forCellReuseIdentifier: serviceListNameCellIdentifier)
        tableView.register(UINib(nibName: "NameWithDisclosureIndicatorTableViewCell", bundle: nil), forCellReuseIdentifier: serviceMasterInListCellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Наименование услуги"
        case 1:
            return "Описание"
        case 2:
            return "Ценовой диапазон"
        default:
            return " "
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0...2:
            return 1
        case 3:
            return creatingService.masters.count + 1
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: serviceNameCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.text = creatingService.name
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: serviceDescriptionCellIdentifier, for: indexPath) as! DescriptionTableViewCell
            cell.descriptionTextView.text = creatingService.description
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: servicePriceCellIdentifier, for: indexPath) as! PriceTableViewCell
            cell.priceFromTextField.text = creatingService.priceFrom
            cell.priceToTextField.text = creatingService.priceTo
            return cell
        case 3:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: serviceListNameCellIdentifier, for: indexPath) as! ListAndAddTableViewCell
                cell.initialize(functionType: .addMaster, currentTableVC: self, listName: "Мастера:")
                return cell
            }
            else{
            let cell = tableView.dequeueReusableCell(withIdentifier: serviceMasterInListCellIdentifier, for: indexPath) as! NameWithDisclosureIndicatorTableViewCell
            cell.nameLabel.text = creatingService.masters[indexPath.row-1].name
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            let DescrCell = DescriptionTableViewCell()
            return DescrCell.CellHeight
        default:
            return 44
        }
    }
}
