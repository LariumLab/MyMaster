//
//  ProfileMastersListTableViewController.swift
//  Scheduling
//
//  Created by macbook on 28.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class ProfileMastersListTableViewController: UITableViewController {

//    var currentService = Service()
    let cellIdentifier = "MasterListCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "NameLabelTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salon.masters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NameLabelTableViewCell
        cell.nameLabel.text = salon.masters[indexPath.row].name
        return cell
    }
}
