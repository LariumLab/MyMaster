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
    let labelCellIdentifier = "ClientRegisterLabelCell"
    var loginVC : LoginViewController?
    
    var nameTextField = UITextField()
    var phoneNumberTextField = UITextField()
    var passwordTextFeild1 = UITextField()
    var passwordTextFeild2 = UITextField()
    var goButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        tableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: textFielCellIdentifier)
        tableView.register(UINib(nibName: "ButtonTableViewCell", bundle: nil), forCellReuseIdentifier: buttonCellIdentifier)
        tableView.register(UINib(nibName: "NameLabelTableViewCell", bundle: nil), forCellReuseIdentifier: labelCellIdentifier)
        
        tableView.tableFooterView = UIView()
        
        if loginVC != nil {
            loginVC?.showRegisterController = false
        }
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 2
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFielCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.placeholder = "Введите Ваше имя"
            nameTextField = cell.textField
            return cell
        case 1:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: textFielCellIdentifier, for: indexPath) as! TextFieldTableViewCell
                cell.textField.placeholder = "Телефон"
                phoneNumberTextField = cell.textField
                return cell
            }
            let textCell = tableView.dequeueReusableCell(withIdentifier: labelCellIdentifier, for: indexPath) as! NameLabelTableViewCell
            textCell.nameLabel.numberOfLines = 0
            textCell.nameLabel.text = "Номер телефона необходим для возможности отправлять заявки на запись в салоны. Также он является логином для входа в аккаунт, поэтому для удобства введите номер в формате xxxxxxxxxxx (без пробелов и скобок)."
            textCell.backgroundColor = UIColor.groupTableViewBackground
            return textCell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFielCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.isSecureTextEntry = true
            cell.textField.placeholder = "Пароль"
            passwordTextFeild1 = cell.textField
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFielCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.isSecureTextEntry = true
            cell.textField.placeholder = "Введите пароль повторно"
            passwordTextFeild2 = cell.textField
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: buttonCellIdentifier, for: indexPath) as! ButtonTableViewCell
            cell.button.setTitle("Зарегистрироватсья", for: .normal)
            goButton = cell.button
            goButton.addTarget(self, action: #selector(sendInfo), for: .touchDown)

            return cell
        default:
            break
        }
        return UITableViewCell()
    }

    @objc func sendInfo() {
        
        let oneOfFieldsIsEmpty = (nameTextField.text?.isEmpty)! || (phoneNumberTextField.text?.isEmpty)! || (passwordTextFeild1.text?.isEmpty)! || (passwordTextFeild2.text?.isEmpty)!
        
        guard !oneOfFieldsIsEmpty else {
            let alertC = UIAlertController(title: "Ошибка", message: "Все поля должны быть заполнены", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alertC.addAction(okAction)
            self.present(alertC, animated: true, completion: nil)
            return
        }
        
        guard (phoneNumberTextField.text?.isValid(regex: .phone))! else {
            let alertC = UIAlertController(title: "Неправильный номер", message: "Проверьте правильность ввода номера телефона", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alertC.addAction(okAction)
            self.present(alertC, animated: true, completion: nil)
            return
        }
        
        guard passwordTextFeild1.text! == passwordTextFeild2.text! else {
            let alertC = UIAlertController(title: "Пароли не совпадают", message: "Проверьте правильность ввода пароля", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alertC.addAction(okAction)
            self.present(alertC, animated: true, completion: nil)
            return
        }
        
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
                
                let alertC = UIAlertController(title: "Ошибка при создании аккаунта", message: "Скорее всего, такой номер уже есть в базе", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
                alertC.addAction(okAction)
                self.present(alertC, animated: true, completion: nil )
                
                self.view.removeBlurLoader()
                return
            }
//            _ = Keychain.save(key: "userToken", data: data)
            
            let alertVC = UIAlertController(title: "Ура!", message: "Регистрация прошла успешно", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alertVC.addAction(okAction)
            self.present(alertVC, animated: true, completion: nil)
            self.view.removeBlurLoader()
            
            // ========
            DispatchQueue.main.async {
                self.navigationController?.viewControllers.removeLast()
            }
            // ========
        }
        task.resume()
        self.view.showBlurLoader()
    }
}
