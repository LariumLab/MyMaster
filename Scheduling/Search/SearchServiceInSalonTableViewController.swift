//
//  SearchServiceInSalonTableViewController.swift
//  Scheduling
//
//  Created by macbook on 12.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class SearchServiceInSalonTableViewController: UITableViewController {

    var service = Service()
    let ServiceNameCellIdentifier = "SearchServiceInSalonTextField"
    let ServiceDescriptionCellIdentidier = "SearchServiceInSalonDescriptionCell"
    let ServicePriceCellIdentifier = "SearchServiceInSalonPriceCell"
    let MasterCellIdentifier = "SearchServiceInSalonMasterInListCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: ServiceNameCellIdentifier)
        tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: ServiceDescriptionCellIdentidier)
        tableView.register(UINib(nibName: "PriceTableViewCell", bundle: nil), forCellReuseIdentifier: ServicePriceCellIdentifier)
        tableView.register(UINib(nibName: "NameWithDisclosureIndicatorTableViewCell", bundle: nil), forCellReuseIdentifier: MasterCellIdentifier)

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
            return "Цена"
        case 3:
            return "Список мастеров:"
        default:
            return ""
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            let TextFieldCell = TextFieldTableViewCell()
            return TextFieldCell.cellHeight
        case 1:
            let DescrCell = DescriptionTableViewCell()
            return DescrCell.CellHeight
        case 2:
            let PriceCell = PriceTableViewCell()
            return PriceCell.CellHeight
        case 3:
            let MasterCell = NameWithDisclosureIndicatorTableViewCell()
            return MasterCell.CellHeight
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0...2:
            return 1
        case 3:
        return service.masters.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ServiceNameCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.text = service.name
            cell.textField.isUserInteractionEnabled = false
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ServiceDescriptionCellIdentidier, for: indexPath) as! DescriptionTableViewCell
            cell.descriptionTextView.text = service.description
            cell.descriptionTextView.isEditable = false
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ServicePriceCellIdentifier, for: indexPath) as! PriceTableViewCell
            cell.priceFromTextField.text = service.priceFrom
            cell.priceFromTextField.isUserInteractionEnabled = false
            cell.priceToTextField.text = service.priceTo
            cell.priceToTextField.isUserInteractionEnabled = false
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: MasterCellIdentifier, for: indexPath) as! NameWithDisclosureIndicatorTableViewCell
            cell.nameLabel.text = service.masters[indexPath.row].name
            return cell
        default:
            return UITableViewCell()
        }
    }
}
