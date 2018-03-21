//
//  PofileClientTableViewController.swift
//  Scheduling
//
//  Created by macbook on 14.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class ProfileSalonServicesTableViewController: UITableViewController {
    
//    var salon = Salon()
//    var ServicesList : [Service] = []
    
    let cellIdentifier = "ServiceCellInSalonProfile"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        salon = TestSalon1 // загрузка
//        ServicesList = salon.services
        
        tableView.register(UINib(nibName: "ServiceCellInSalonProfileTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servicesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let serviceName : String = servicesList[indexPath.row].name
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if let castedCell = cell as? ServiceCellInSalonProfileTableViewCell{
            castedCell.setServicesNameLabel(name: serviceName)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let addServiceVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddServiceInSalonProfile") as! ProfileAddNewServiceHatTableViewController
        
        addServiceVC.serviceName = servicesList[indexPath.row].name
        addServiceVC.serviceDescription = servicesList[indexPath.row].description
        addServiceVC.priceTo = ""
        addServiceVC.priceFrom  = ""
        
        let addServiceMastersVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddServiceMastersInSalonProfile") as! ProfileAddNewServiceMastersTableViewController
        
        addServiceMastersVC.mastersListForService = servicesList[indexPath.row].masters
        
        self.navigationController?.pushViewController(addServiceVC, animated: true)
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
