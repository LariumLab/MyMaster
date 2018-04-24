//
//  RequestsTableViewController.swift
//  Scheduling
//
//  Created by macbook on 23.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class RequestsTableViewController: UITableViewController {

    var testRequests : [SalonRequest] = []
    let reguestCellIdentifier = "RequestCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "SalonRequestTableViewCell", bundle: nil), forCellReuseIdentifier: reguestCellIdentifier)
        
        // ================
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:HH dd.MM.yyyy"
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")! as TimeZone
        let date1 = formatter.date(from: "12:00 17.04.2018")
        let date2 = formatter.date(from: "16:00 18.04.2018")
        let date3 = formatter.date(from: "13:00 19.04.2018")

        let salonRequest1 = SalonRequest(client: Client1, serviceName: "Tattoo", master: MasterKostya, time: date1!, description: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
        let salonRequest2 = SalonRequest(client: Client1, serviceName: "Piersing", master: MasterKostya, time: date2!, description: "bbbbbbbbbbbbb")
        let salonRequest3 = SalonRequest(client: Client1, serviceName: "Dreadlocks", master: MasterKostya, time: date3!, description: "kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk")
        testRequests = [salonRequest1, salonRequest2, salonRequest3]
        // ================

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testRequests.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reguestCellIdentifier, for: indexPath) as! SalonRequestTableViewCell
        
        let request = testRequests[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:HH dd.MM.yyyy"
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")! as TimeZone
        cell.clientNameLabel.text = request.client.name
        cell.clientNumberLabel.text = request.client.phoneNumber
        cell.masterNameLabel.text = request.master.name
        cell.timeLabel.text = formatter.string(from: request.time)
        cell.descriptionLabel.text = request.description
        
        return cell
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
