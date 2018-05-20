//
//  NameWithSwitchTableViewCell.swift
//  Scheduling
//
//  Created by macbook on 30.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class NameWithSwitchTableViewCell: UITableViewCell {
    
    var cellOwnerVC = UITableViewController() //for example: ProfileAddNewMasterTVC
    var cellNumberInSection : Int = 0
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        if cellOwnerVC is ProfileAddNewMasterTableViewController {
            let tvc = cellOwnerVC as! ProfileAddNewMasterTableViewController
            if tvc.switchBoolVector[cellNumberInSection] == true {
                tvc.switchBoolVector[cellNumberInSection] = false
            }
            else {
                tvc.switchBoolVector[cellNumberInSection] = true
            }
            tvc.updatePositionsOfTrueInSwitchBoolVector()
            tvc.startAndEndTextFields = []
            tvc.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var switchOutlet: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
