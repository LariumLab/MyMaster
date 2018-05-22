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
    var mastersList : [ (String, String) ] = [] // (name, masterID)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "NameLabelTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mastersList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NameLabelTableViewCell
        cell.nameLabel.text = mastersList[indexPath.row].0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let CreateServiceVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileAddService") as! ProfileAddNewServiceTableViewController
        CreateServiceVC.mastersIDAndName.append( mastersList[indexPath.row])
        print(CreateServiceVC.nameTextField.text)
        self.navigationController?.viewControllers.removeLast()
//        let CreateServiceVC = self.navigationController?.viewControllers.last as! ProfileAddNewServiceTableViewController
//        CreateServiceVC.mastersIDAndName.append( mastersList[indexPath.row])

    }
}
