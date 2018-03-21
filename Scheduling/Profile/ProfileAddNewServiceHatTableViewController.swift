//
//  ProfileAddNewServiceTableViewController.swift
//  Scheduling
//
//  Created by macbook on 19.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class ProfileAddNewServiceHatTableViewController: UITableViewController {
    
    @IBAction func addMaster(_ sender: UIButton) {
        let alert = UIAlertController(title: "Добавление мастера", message: "Вы можете создать нового мастера или выбрать уже существующих из списка.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Добавить из списка", style: .default, handler: { (action) in
            
            var MastersTableVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChooseMasterInAddService") as! UITableView
            
            alert.dismiss(animated: false, completion: nil)
        }))
    }
    
//    var mastersList : [Master] = []
    
    @IBOutlet weak var serviceNameTextField: UITextField!
    @IBOutlet weak var serviceDescriptionTextView: UITextView!
    @IBOutlet weak var priceFromTextField: UITextField!
    @IBOutlet weak var priceToTextField: UITextField!
    
    var serviceName = ""
    var serviceDescription = ""
    var priceFrom = ""
    var priceTo = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        serviceNameTextField.text = serviceName
        serviceDescriptionTextView.text = serviceDescription
        priceFromTextField.text = priceFrom
        priceToTextField.text = priceTo
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
