//
//  SalonRegisterTableViewController.swift
//  Scheduling
//
//  Created by macbook on 21.05.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class SalonRegisterTableViewController: UITableViewController {

    let textFieldCellIdentifier = "SalonRegisterTextFieldCell"
    let descrtiptionCellIdentifer = "SalonRegisterDescriptionCell"
    let buttonCellIdentifirer = "SalonRegisterButtonCell"

    var nicknameTextField = UITextField()
    var salonNameTextField = UITextField()
    var descriptionTextView = UITextView()
    var phoneNumberTextField = UITextField()
    var cityTextField = UITextField()
    var fullAdressTextField = UITextField()
    var passwordTextField1 = UITextField()
    var passwordTextField2 = UITextField()
    var goButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: textFieldCellIdentifier)
        tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: descrtiptionCellIdentifer)
        tableView.register(UINib(nibName: "ButtonTableViewCell", bundle: nil), forCellReuseIdentifier: buttonCellIdentifirer)

    }

    @objc func sendNickNameAndPass() {
        let phoneNumber = phoneNumberTextField.text!
        let salonName = salonNameTextField.text!
        let descriptionForSalon = descriptionTextView.text!
        let city = cityTextField.text!
        let fullAdress = fullAdressTextField.text!
        
        let nicknameAndPassURL = serverAdr + "api/salon/signUp?nickName=" + nicknameTextField.text! + "&password=" + passwordTextField1.text!
        let URLNickNameAndPass = URL(string: nicknameAndPassURL)
        
        let createdSalonInfo = JSONCreateSalonInfo(customName: salonName, phoneNumber: phoneNumber, description: descriptionForSalon, city: city, address: fullAdress)
        let createdSalonInfoInJSON = try? JSONEncoder().encode(createdSalonInfo)
        
        guard (URLNickNameAndPass != nil) && (createdSalonInfoInJSON != nil) else {
            return
        }
        
        let JSONString = String(data: createdSalonInfoInJSON!, encoding: .utf8)!

        var requestNicknameAndPass = URLRequest(url: URLNickNameAndPass!)
        requestNicknameAndPass.httpMethod = "POST"
        requestNicknameAndPass.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestNicknameAndPass.httpBody = JSONString.data(using: .utf8)
        
//        createdSalonInfoInJSON
        
        let sendNicknameAndPassTask = URLSession.shared.dataTask(with: requestNicknameAndPass) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            print("RESPONSE")
            print(response ?? "response")
            
//            let salonToken = String(data: data, encoding: .utf8)
        }
        sendNicknameAndPassTask.resume()
    }
    
    @objc func sendInfo() {
        let infoURL = serverAdr
        
        let URLInfo = URL(string: infoURL)
        guard URLInfo != nil else {
            return
        }
        
        var request = URLRequest(url: URLInfo!)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            print("DATA" + String(data: data, encoding: .utf8)!)
            
            _ = Keychain.save(key: "userToken", data: data)
            
            // ALERT C  -> OK, than
            
            DispatchQueue.main.async {
                self.navigationController?.viewControllers.removeLast()
            }
        }
        task.resume()
        
        
        print("YES")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 9
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Никнейм"
        case 1:
            return "Название салона"
        case 2:
            return "Описание"
        case 3:
            return "Телефон"
        case 4:
            return "Город"
        case 5:
            return "Полный адрес"
        case 6:
            return "Пароль"
        case 7:
            return "Повторите пароль"
        default:
            return " "
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            let descrCell = DescriptionTableViewCell()
            return descrCell.CellHeight
        }
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            nicknameTextField = cell.textField
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            salonNameTextField = cell.textField
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: descrtiptionCellIdentifer, for: indexPath) as! DescriptionTableViewCell
            cell.descriptionTextView.text = ""
            descriptionTextView = cell.descriptionTextView
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.keyboardType = .phonePad
            phoneNumberTextField = cell.textField
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cityTextField = cell.textField
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            fullAdressTextField = cell.textField
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
             cell.textField.textContentType = UITextContentType.password
            passwordTextField1 = cell.textField
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.textContentType = UITextContentType.password
            passwordTextField2 = cell.textField
            return cell
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: buttonCellIdentifirer, for: indexPath) as! ButtonTableViewCell
            goButton = cell.button
            goButton.addTarget(self, action: #selector(sendNickNameAndPass), for: .touchDown)
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