//
//  AddNewServiceTableViewController.swift
//  Scheduling
//
//  Created by macbook on 24.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class ProfileAddNewServiceTableViewController: UITableViewController {

    @objc func addService() {
        let name = nameTextField.text!
        let descriptionServ = descriptionTextView.text!
        let priceFrom = priceFromTextField.text!
        let priceTo = priceToTextField.text!
        
        if name.isEmpty || descriptionServ.isEmpty || priceFrom.isEmpty || priceTo.isEmpty  {
            let alertC = UIAlertController(title: "Ошибка", message: "Все поля должны быть заполнены", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alertC.addAction(okAction)
            self.present(alertC, animated: true, completion: nil)
            return
        }
        
        if priceFrom > priceTo {
            let alertC = UIAlertController(title: "Неправильный ценовой диапазон", message: "Цена \"От\" больше, чем цена \"До\"", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alertC.addAction(okAction)
            self.present(alertC, animated: true, completion: nil)
            return
        }
        
        let sendServiceInfoURL = serverAdr + "api/salon/addService?token=" + "5411aa4b553a4fd6331dbe9bb7f5abc6"
        //Keychain.load(key: "userToken")
        
        let salonInfo = JSONCreateServiceInfo(name: name, description: descriptionServ, priceFrom: priceFrom, priceTo: priceTo)
        let salonInfoInJSON = try? JSONEncoder().encode(salonInfo)
        
        guard let URLsendServiceInfo = URL(string: sendServiceInfoURL) else {
            return
        }
        
        guard salonInfoInJSON != nil  else {
            return
        }
        
        var requestSendSalonInfo = URLRequest(url: URLsendServiceInfo)
        requestSendSalonInfo.httpMethod = "POST"
        requestSendSalonInfo.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestSendSalonInfo.httpBody = salonInfoInJSON
        
        let task1 = URLSession.shared.dataTask(with: requestSendSalonInfo){ data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            print("RESPONSE")
            print(response ?? "response")
            
            let serviceID = String(data: data, encoding: .utf8)
            
            for master in self.mastersIDAndName {
                var setMastertiServiceURL = serverAdr + "/api/salon/addMasterToService?token="
                    //Keychain.load(key: "userToken")
                    setMastertiServiceURL += "5411aa4b553a4fd6331dbe9bb7f5abc6"
                    setMastertiServiceURL += "&serviceID="
                    setMastertiServiceURL += serviceID!
                    setMastertiServiceURL += "&masterID="
                    setMastertiServiceURL += master.1
                
                guard let URLsetMastertiService = URL(string: setMastertiServiceURL) else {
                    return
                }
                var requestSetupMastersToService = URLRequest(url: URLsetMastertiService)
                requestSetupMastersToService.httpMethod = "POST"
                
                let task2 = URLSession.shared.dataTask(with: requestSendSalonInfo){ data, response, error in
                    guard let data = data, error == nil else {
                        print(error?.localizedDescription ?? "No data")
                        return
                    }
                    print("RESPONSE")
                    print(response ?? "response")
                    
                }
                task2.resume()
            }
            
        }
        task1.resume()
    }
    
    var nameTextField = UITextField()
    var descriptionTextView = UITextView()
    var priceFromTextField = UITextField()
    var priceToTextField = UITextField()
    
//    var creatingService = Service()
//    var crService = JSONCreateSalonInfo()
    
    var mastersIDAndName : [(String, String)] = [] // (name, ID)
    var salonID = UUID()
    
    let serviceNameCellIdentifier = "AddServiceNameCell"
    let serviceDescriptionCellIdentifier = "AddServiceDescriptionCell"
    let servicePriceCellIdentifier = "AddServicePriceCell"
    let serviceListNameCellIdentifier = "AddServiceListNameCell"
    let serviceMasterInListCellIdentifier = "AddServiceMasterInListCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        let createServiceButton = UIBarButtonItem(title: "Создать", style: .done, target: self, action: #selector(addService))
        navigationItem.rightBarButtonItem = createServiceButton
        
        tableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: serviceNameCellIdentifier)
        tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: serviceDescriptionCellIdentifier)
        tableView.register(UINib(nibName: "PriceTableViewCell", bundle: nil), forCellReuseIdentifier: servicePriceCellIdentifier)
        tableView.register(UINib(nibName: "ListAndAddTableViewCell", bundle: nil), forCellReuseIdentifier: serviceListNameCellIdentifier)
        tableView.register(UINib(nibName: "NameWithDisclosureIndicatorTableViewCell", bundle: nil), forCellReuseIdentifier: serviceMasterInListCellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Наименование услуги"
        case 1:
            return "Описание"
        case 2:
            return "Ценовой диапазон"
        default:
//            return " "
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0...2:
            return 1
        case 3:
            return mastersIDAndName.count + 1
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: serviceNameCellIdentifier, for: indexPath) as! TextFieldTableViewCell
            cell.textField.text = ""
            let gamma = blueGamma()
            gamma.makeViewStyle(view: cell.textField, color: gamma.whiteColor, radius: 5)
            nameTextField = cell.textField
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: serviceDescriptionCellIdentifier, for: indexPath) as! DescriptionTableViewCell
            cell.descriptionTextView.text = ""
            let gamma = blueGamma()
            gamma.makeViewStyle(view: cell.descriptionTextView, color: gamma.whiteColor, radius: 5)
            descriptionTextView = cell.descriptionTextView
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: servicePriceCellIdentifier, for: indexPath) as! PriceTableViewCell
            cell.priceFromTextField.text = ""
            let gamma = blueGamma()
            gamma.makeViewStyle(view: cell.priceToTextField, color: gamma.whiteColor, radius: 5)
            gamma.makeViewStyle(view: cell.priceFromTextField, color: gamma.whiteColor, radius: 5)
            priceFromTextField = cell.priceFromTextField
            priceToTextField = cell.priceToTextField
            return cell
        case 3:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: serviceListNameCellIdentifier, for: indexPath) as! ListAndAddTableViewCell
                cell.initialize(functionType: .addMaster, currentTableVC: self, listName: "Мастера:")
                let gamma = blueGamma()
                gamma.makeViewStyle(view: cell.colorView, color: gamma.skyBlue, radius: 5)
                cell.addButton.tintColor = gamma.darkBlue

                return cell
            }
            else{
            let cell = tableView.dequeueReusableCell(withIdentifier: serviceMasterInListCellIdentifier, for: indexPath) as! NameWithDisclosureIndicatorTableViewCell
            cell.nameLabel.text = mastersIDAndName[indexPath.row-1].0
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            let DescrCell = DescriptionTableViewCell()
            return DescrCell.CellHeight
        default:
            return 44
        }
    }
}
