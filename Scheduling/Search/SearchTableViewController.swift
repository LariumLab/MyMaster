//
//  SearchTableViewController.swift
//  Scheduling
//
//  Created by macbook on 24.02.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    let cellIdentifier = "SearchCityCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NameWithDisclosureIndicatorTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NameWithDisclosureIndicatorTableViewCell
        cell.nameLabel.text = cities[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        let SalonsInCityVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchSalonsInCityTable") as! SearchSalonsInCityTableViewController
     //   SalonsInCityVC.salonsInSity = get запрос на сервер
        SalonsInCityVC.city = city
        self.navigationController?.pushViewController(SalonsInCityVC, animated: true)
    }

}
