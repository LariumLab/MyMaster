//
//  ProfileClientTableViewController.swift
//  Scheduling
//
//  Created by macbook on 10.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class ProfileClientTableViewController: UITableViewController {

    var registeredClient = Client() // Загрузка, load data
    
    var appointments : [ClientAppointment] = []
    let profileClientCellIdentifier = "ProfileClientDescription"
    let appointmentCellIdentifier = "ProfileClientAppointment"
    let LabelCellIdentifier = "ProfileClientLabel"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registeredClient = client

        tableView.register(UINib(nibName: "ProfileClientDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: profileClientCellIdentifier)
        tableView.register(UINib(nibName: "ClientAppointmentTableViewCell", bundle: nil), forCellReuseIdentifier: appointmentCellIdentifier)
        tableView.register(UINib(nibName: "NameLabelTableViewCell", bundle: nil), forCellReuseIdentifier: LabelCellIdentifier)
        
        self.navigationItem.title = "Профиль"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Настройки", style: .done, target: self, action: #selector(settingsButtonSelected) )
        tableView.tableFooterView = UIView()
        appointments = registeredClient.appointments
    }

    @objc func settingsButtonSelected() {
        let settingsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileSettings") as! ProfileSettingsTableViewController
        settingsVC.profile = self.registeredClient
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if appointments.count == 0 { return 2 }
        else { return 1 + appointments.count }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            let descCell = ProfileClientDescriptionTableViewCell()
            return descCell.CellHeigh
        }
        else {
            if appointments.count == 0 {
                return 44
            }
            else {
                let appointmentCell = ClientAppointmentTableViewCell()
                return appointmentCell.CellHeigh
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: profileClientCellIdentifier, for: indexPath) as! ProfileClientDescriptionTableViewCell
            cell.nameLabel.text = registeredClient.name
            cell.phoneNumberLabel.text = registeredClient.phoneNumber
            return cell
        default:
            guard appointments.count != 0 else {
                let cell = tableView.dequeueReusableCell(withIdentifier: LabelCellIdentifier, for: indexPath) as! NameLabelTableViewCell
                cell.nameLabel.text = "У Вас ещё нет записей :("
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: appointmentCellIdentifier, for: indexPath) as! ClientAppointmentTableViewCell
            let appointment = appointments[indexPath.row - 1]
            cell.serviceNameLabel.text = appointment.serviceName
            cell.priceLabel.text = appointment.price
            cell.dateLabel.text = appointment.timeAndDate
            cell.salonNameLabel.text = appointment.salonName
            cell.salonAdressLabel.text = appointment.salonAdress
            return cell
        }
        
//        if indexPath.row == 0 {
//
//        }
//        else{
//
//        }
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
