//
//  SearchSalonsInCityTableViewController.swift
//  Scheduling
//
//  Created by macbook on 11.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class SearchSalonsInCityTableViewController: UITableViewController {
    
    var city : String = ""
    var salonsInCity : [ SalonPreview ] = [ ]
    let cellIdentifier = "SearchSalonInCityCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SearchSalonTableViewCell" , bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.title = city
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salonsInCity.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let salonCell = SearchSalonTableViewCell()
//        return salonCell.cellHeight
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SearchSalonTableViewCell
<<<<<<< HEAD
        let currentSalon : (String, String)  = salonsInSity[indexPath.row]
        cell.nameLabel.text = currentSalon.0
        cell.adressLabel.text = currentSalon.1
        let gamma = blueGamma()
=======
        let currentSalon : SalonPreview  = salonsInCity[indexPath.row]
        cell.nameLabel.text = currentSalon.customName
        cell.adressLabel.text = currentSalon.address
>>>>>>> d926b0bac4eb13698d2f29f1d5ba31bf2db0afd0
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let SalonVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchSalon") as! SearchSalonTableViewController
//        SalonVC.currentSalon = salonsInSity[indexPath.row]
        self.navigationController?.pushViewController(SalonVC, animated: true)
        
    }
}
