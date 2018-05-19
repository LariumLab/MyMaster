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

        let currentSalon : SalonPreview  = salonsInCity[indexPath.row]
        cell.nameLabel.text = currentSalon.customName
        cell.adressLabel.text = currentSalon.address
        let gamma = blueGamma()
        gamma.makeViewStyle(view: cell.colorView, color: gamma.biegeColor, radius: 10)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let SalonVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchSalon") as! SearchSalonTableViewController
        
        let salon = salonsInCity[indexPath.row]
        let salonID = salon.ID
            let stringURL =  serverAdr + "api/getSalonInfo?salonID=" + salonID.uuidString
            guard let URLGetSalonListInCity = URL(string: stringURL) else {
                return
            }
            URLSession.shared.dataTask(with: URLGetSalonListInCity) { (data, response, error) in
                guard let data = data else { return }
                do {
                    let salonInfo = try JSONDecoder().decode(SalonInfo.self, from: data)
                    SalonVC.currentSalon.adress = salon.address
                    SalonVC.currentSalon.name = salon.customName
                    SalonVC.currentSalon.ID = salon.ID.uuidString
                    SalonVC.currentSalon.description = salonInfo.description
                    SalonVC.currentSalon.phoneNumber = salonInfo.phoneNumber
                    SalonVC.currentSalon.nickname = salonInfo.nickName
                    SalonVC.currentSalon.city = self.city
                    
                    DispatchQueue.main.async {
                        SalonVC.view.removeBlurLoader()
                        SalonVC.tableView.reloadData()
                    }
                } catch let err {
                    print(err)
                }
                }.resume()
        self.navigationController?.pushViewController(SalonVC, animated: true)
        SalonVC.view.showBlurLoader()
    }
}
