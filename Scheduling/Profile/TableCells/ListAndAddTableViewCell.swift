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
//            profileSalon.navigationController?.pushViewController(addServiceVC, animated: true)
        //            case .addMaster:
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
