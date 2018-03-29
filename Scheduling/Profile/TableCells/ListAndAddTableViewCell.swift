//
//  ListAndAddTableViewCell.swift
//  Scheduling
//
//  Created by macbook on 24.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class ListAndAddTableViewCell: UITableViewCell {
   
    @IBOutlet weak var listNameLabel: UILabel!

    enum AddFunctionType {
        case addService
        case addMaster
    }
    
    var AddFunction : AddFunctionType? = nil
    var currentTableVC = UITableViewController()
    
    func initialize(functionType: AddFunctionType, currentTableVC: UITableViewController, listName: String) {
        AddFunction = functionType
        self.currentTableVC = currentTableVC
        listNameLabel.text = listName
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard AddFunction != nil else { print("Тип функции не инициилизирован -> кнопка не работает"); return }
        
        switch AddFunction {
        case .addService?:
            let addServiceVC = storyboard.instantiateViewController(withIdentifier: "ProfileAddService")
            currentTableVC.navigationController?.pushViewController(addServiceVC, animated: true)
        case .addMaster?:
            let alertC = UIAlertController(title: "Добавление мастера", message: "Создать нового мастера или выбрать из списка уже существующих?", preferredStyle: .alert)
            let CurrentAddNewServiceVC = self.currentTableVC as!ProfileAddNewServiceTableViewController
            
            let addFromListAlertAction = UIAlertAction(title: "Добавить из списка", style: .default) { (alert) in
                let MastersListTableVC = storyboard.instantiateViewController(withIdentifier: "ProfileMastersList") as! ProfileMastersListTableViewController
                MastersListTableVC.currentService = CurrentAddNewServiceVC.creatingService
                CurrentAddNewServiceVC.navigationController?.pushViewController(MastersListTableVC, animated: true)
            }
            let addNewMasterAlertAction = UIAlertAction(title: "Создать нового", style: .default) { (alert) in
                
                let addNewMasterTableVC = storyboard.instantiateViewController(withIdentifier: "ProfileAddNewMaster") as! ProfileAddNewMasterTableViewController
                addNewMasterTableVC.currentServce = CurrentAddNewServiceVC.creatingService
                CurrentAddNewServiceVC.navigationController?.pushViewController(addNewMasterTableVC, animated: true)
            }
            alertC.addAction(addFromListAlertAction)
            alertC.addAction(addNewMasterAlertAction)
            CurrentAddNewServiceVC.present(alertC, animated: true, completion: nil)
        default: break
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
