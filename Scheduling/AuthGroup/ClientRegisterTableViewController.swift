//
//  ClientRegisterTableViewController.swift
//  Scheduling
//
//  Created by macbook on 21.05.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class ClientRegisterTableViewController: UITableViewController {

    let textFielCellIdentifier = "ClientRegisterTextFieldCell"
    let buttonCellIdentifier = "ClientRegisterButtonCell"
    
    var nameTextField = UITextField()
    var phoneNumberTextField = UITextField()
    var passwordTextFeild1 = UITextField()
    var passwordTextFeild2 = UITextField()
    var goButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: textFielCellIdentifier)
        tableView.register(UINib(nibName: "ButtonTableViewCell", bundle: nil), forCellReuseIdentifier: buttonCellIdentifier)
    }
    
    @objc func sendInfo() {
        var infoURL = serverAdr + "api/client/signUp?phoneNumber=" + phoneNumberTextField.text!
        infoURL += "&name=" + nameTextField.text!
        infoURL += "&password=" + passwordTextFeild1.text!
        
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
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Как к Вам обращаться?"
        case 1:
            return "Введите номер телефона"
        case 2:
            return "Придумайте пароль"
        case 3:
            return "Подтверждение пароля"
        default:
            return " "
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Номер телефона необходим для возможности отправлять заявки на запись в салоны. Также он является логином для входа в аккаунт."
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFielCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.placeholder = "Введите Ваше имя"
            nameTextField = cell.textField
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFielCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.placeholder = "Телефон"
            phoneNumberTextField = cell.textField
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFielCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.textContentType = UITextContentType.password
            cell.textField.placeholder = "Пароль"
            passwordTextFeild1 = cell.textField
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFielCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.textContentType = UITextContentType.password
            cell.textField.placeholder = "Подтверждение паролья"
            passwordTextFeild2 = cell.textField
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: buttonCellIdentifier, for: indexPath) as! ButtonTableViewCell
            goButton = cell.button
            goButton.addTarget(self, action: #selector(sendInfo), for: .touchDown)

            return cell
        default:
            break
        }
        return UITableViewCell()
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
