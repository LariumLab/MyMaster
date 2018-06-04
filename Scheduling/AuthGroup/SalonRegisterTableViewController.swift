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
        self.hideKeyboardWhenTappedAround()
        
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
        
        let oneOfFieldsIsEmpty = (nicknameTextField.text?.isEmpty)! || (passwordTextField1.text?.isEmpty)! || (passwordTextField2.text?.isEmpty)! || salonName.isEmpty || descriptionForSalon.isEmpty || phoneNumber.isEmpty || city.isEmpty || fullAdress.isEmpty
        
        guard !oneOfFieldsIsEmpty else {
            let alertC = UIAlertController(title: "Ошибка", message: "Все поля должны быть заполнены", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alertC.addAction(okAction)
            self.present(alertC, animated: true, completion: nil)
            return
        }
        
        guard (phoneNumber.isValid(regex: .phone)) else {
            let alertC = UIAlertController(title: "Неправильный номер", message: "Проверьте правильность ввода номера телефона", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alertC.addAction(okAction)
            self.present(alertC, animated: true, completion: nil)
            return
        }
        
        guard passwordTextField1.text! == passwordTextField2.text! else {
            let alertC = UIAlertController(title: "Пароли не совпадают", message: "Проверьте правильность ввода пароля", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alertC.addAction(okAction)
            self.present(alertC, animated: true, completion: nil)
            return
        }
        
        let nicknameAndPassURL = serverAdr + "api/salon/signUp?nickName=" + nicknameTextField.text! + "&password=" + passwordTextField1.text!
        let URLNickNameAndPass = URL(string: nicknameAndPassURL)
        
        let createdSalonInfo = JSONCreateSalonInfo(customName: salonName, phoneNumber: phoneNumber, description: descriptionForSalon, city: city, address: fullAdress)
        let createdSalonInfoInJSON = try? JSONEncoder().encode(createdSalonInfo)
        
        guard (URLNickNameAndPass != nil) && (createdSalonInfoInJSON != nil) else {
            return
        }
        
//        let JSONString = String(data: createdSalonInfoInJSON!, encoding: .utf8)!

        var requestNicknameAndPass = URLRequest(url: URLNickNameAndPass!)
        requestNicknameAndPass.httpMethod = "POST"
        requestNicknameAndPass.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestNicknameAndPass.httpBody = createdSalonInfoInJSON
//        requestNicknameAndPass.httpBody = JSONString.data(using: .utf8)
        
        let sendNicknameAndPassTask = URLSession.shared.dataTask(with: requestNicknameAndPass) { data, response, error in
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                let alertC = UIAlertController(title: "Ошибка при создании аккаунта", message: "Ошибка при подключении к серверу", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
                alertC.addAction(okAction)
                self.present(alertC, animated: true, completion: nil )
                return
            }
            
            let httpResponse = response as? HTTPURLResponse
            guard httpResponse?.statusCode != 409 else {
                let alertC = UIAlertController(title: "Такой никнейм уже существует", message: "Придумайте другой никнейм и попробуйте ещё раз", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
                alertC.addAction(okAction)
                self.present(alertC, animated: true, completion: nil )
                self.view.removeBlurLoader()
                return
            }
            
            let alertVC = UIAlertController(title: "Ура!", message: "Регистрация прошла успешно", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alertVC.addAction(okAction)
            self.present(alertVC, animated: true, completion: nil)
            self.view.removeBlurLoader()
            
            
            self.navigationController?.viewControllers.removeLast()

//            DispatchQueue.main.async {
//                self.navigationController?.viewControllers.removeLast()
//            }
            
//            let salonToken = String(data: data, encoding: .utf8)
        }
        sendNicknameAndPassTask.resume()
        self.view.showBlurLoader()
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
            cell.textField.placeholder = "Введите никнейм"
            nicknameTextField = cell.textField
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.placeholder = "Введите название салона"
            salonNameTextField = cell.textField
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: descrtiptionCellIdentifer, for: indexPath) as! DescriptionTableViewCell
            cell.descriptionTextView.text = ""
            cell.descriptionTextView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
            cell.descriptionTextView.layer.borderWidth = 1
            cell.descriptionTextView.layer.cornerRadius = 5
            descriptionTextView = cell.descriptionTextView
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.keyboardType = .phonePad
            cell.textField.placeholder = "Номер телефона для записей"
            phoneNumberTextField = cell.textField
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.placeholder = "Введите город, в котором находится салон"
            cityTextField = cell.textField
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.placeholder = "Введите полный адрес салона"
            fullAdressTextField = cell.textField
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.isSecureTextEntry = true
            passwordTextField1 = cell.textField
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.isSecureTextEntry = true
            passwordTextField2 = cell.textField
            return cell
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: buttonCellIdentifirer, for: indexPath) as! ButtonTableViewCell
            cell.button.setTitle("Зарегистрироваться", for: .normal)
            goButton = cell.button
            goButton.addTarget(self, action: #selector(sendNickNameAndPass), for: .touchDown)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
