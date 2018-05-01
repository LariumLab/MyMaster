//
//  CreateRequestTableViewController.swift
//  Scheduling
//
//  Created by macbook on 29.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class CreateRequestTableViewController: UITableViewController {

    var master = Master()
    var serviceName = ""
    let descriptionCellIdentifier = "SearchAddRequestDescription"
    let requestCellIdentifier = "SearchAddRequest"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "AddRequestDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: descriptionCellIdentifier)
        tableView.register(UINib(nibName: "AddRequestTableViewCell", bundle: nil), forCellReuseIdentifier: requestCellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: descriptionCellIdentifier, for: indexPath) as! AddRequestDescriptionTableViewCell
            cell.serviceLabel.text = "Запись на услугу: " + "\(serviceName)"
            cell.masterLabel.text = "К мастеру: " + "\(master.name)"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: requestCellIdentifier, for: indexPath) as! AddRequestTableViewCell
            cell.tableView = self.tableView
            cell.load()
            return cell
        default:
            return UITableViewCell()
        }
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
