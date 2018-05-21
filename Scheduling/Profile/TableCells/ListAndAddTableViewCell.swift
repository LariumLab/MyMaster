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
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var addButton: UIButton!
    
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
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        
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
                
                let getMastersListURL = serverAdr + "api/getSalonMasters?salonID=" + "4ad6b313-3026-43f8-99df-b969cdc1d95d"
                    // salon.ID
                guard let URLgetMastersList = URL(string: getMastersListURL) else {
                    return
                }
                URLSession.shared.dataTask(with: URLgetMastersList) { (data, response, error) in
                    guard let data = data else { return }
                    do {
                        let mastersList : [JSONMaster] = try JSONDecoder().decode([JSONMaster].self, from: data)
                        for master in mastersList {
                            MastersListTableVC.mastersList.append( (master.name, master.masterID.uuidString) )
                        }
                                                
                        DispatchQueue.main.async {
                            MastersListTableVC.view.removeBlurLoader()
                            MastersListTableVC.tableView.reloadData()
                        }
                    } catch let err {
                        print(err)
                    }
                    }.resume()
                
                CurrentAddNewServiceVC.navigationController?.pushViewController(MastersListTableVC, animated: true)
                MastersListTableVC.view.showBlurLoader()
                
                //                MastersListTableVC.currentService = CurrentAddNewServiceVC.creatingService
//                CurrentAddNewServiceVC.navigationController?.pushViewController(MastersListTableVC, animated: true)
            }
            let addNewMasterAlertAction = UIAlertAction(title: "Создать нового", style: .default) { (alert) in
                
                let addNewMasterTableVC = storyboard.instantiateViewController(withIdentifier: "ProfileAddNewMaster") as! ProfileAddNewMasterTableViewController
                //                addNewMasterTableVC.currentServce = CurrentAddNewServiceVC.creatingService
                addNewMasterTableVC.salonID =
                    CurrentAddNewServiceVC.salonID
                CurrentAddNewServiceVC.navigationController?.pushViewController(addNewMasterTableVC, animated: true)
            }
            
            let cancelButton = UIAlertAction(title: "Отмена", style: .default, handler: nil)
            alertC.addAction(addFromListAlertAction)
            alertC.addAction(addNewMasterAlertAction)
            alertC.addAction(cancelButton)
            CurrentAddNewServiceVC.present(alertC, animated: true, completion: nil)
        default: break
        }
    }
    
    //    func MakeEffects(viewColor: UIColor, addButtonColor: UIColor, radius: CGFloat ) {
    //        addButton.tintColor = addButtonColor
    //        colorView.layer.cornerRadius = radius
    //        colorView.backgroundColor = viewColor
    //    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
