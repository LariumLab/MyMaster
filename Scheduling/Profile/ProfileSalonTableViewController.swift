//
//  ProfileSalonTableViewController.swift
//  Scheduling
//
//  Created by macbook on 27.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class ProfileSalonTableViewController: UITableViewController {
    
    var salon = TestSalon1 // Загрузка
    let DescriptionCellIdentifier = "ProfileSalonDescriptionCell"
    let ListAndAddCellIdentifier = "ProfileSalonListAndAddCell"
    let ServiceCellIdentifier = "ProfileSalonServiceCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ProfileSalonDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: DescriptionCellIdentifier)
        tableView.register(UINib(nibName: "ListAndAddTableViewCell", bundle: nil), forCellReuseIdentifier: ListAndAddCellIdentifier)
        tableView.register(UINib(nibName: "NameWithDisclosureIndicatorTableViewCell", bundle: nil), forCellReuseIdentifier: ServiceCellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + salon.services.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 253
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCellIdentifier, for: indexPath) as! ProfileSalonDescriptionTableViewCell
            cell.organizationNameLabel.text = salon.name
            cell.descriptionTextView.text = salon.description
            cell.telephoneNumberLabel.text = salon.phoneNumber
            cell.cityLabel.text = salon.city
            cell.fullAdressButton.titleLabel?.text = salon.adress
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ListAndAddCellIdentifier, for: indexPath) as! ListAndAddTableViewCell
            cell.initialize(functionType: .addService, currentTableVC: self, listName: "Услуги:")
            return cell
        case 2...(salon.services.count + 2):
            let cell = tableView.dequeueReusableCell(withIdentifier: ServiceCellIdentifier, for: indexPath) as! NameWithDisclosureIndicatorTableViewCell
            cell.nameLabel.text = salon.services[indexPath.row-2].name
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addNewServiceVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileAddService") as! ProfileAddNewServiceTableViewController
        addNewServiceVC.creatingService = salon.services[indexPath.row-2]
        self.navigationController?.pushViewController(addNewServiceVC, animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
