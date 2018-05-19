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
        SalonsInCityVC.city = city
        
        let stringURL = serverAdr + "api/getSalonListInCity?city=" + city
        guard let ruStringURL = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
            guard let URLGetSalonListInCity = URL(string: ruStringURL) else {
                return
            }
            URLSession.shared.dataTask(with: URLGetSalonListInCity) { (data, response, error) in
                guard let data = data else { return }
                do {
                    let salonsInCity = try JSONDecoder().decode([JSONSalonPreview].self, from: data)
                    SalonsInCityVC.salonsInCity = salonsInCity
                    DispatchQueue.main.async {
                        SalonsInCityVC.view.removeBlurLoader()
                        SalonsInCityVC.tableView.reloadData()
                    }
                } catch let err {
                    print(err)
                }
                }.resume()
        
        self.navigationController?.pushViewController(SalonsInCityVC, animated: true)
        SalonsInCityVC.view.showBlurLoader()
    }
}
