//
//  ProfileClientHatTableViewController.swift
//  Scheduling
//
//  Created by macbook on 18.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class ProfileSalonHatTableViewController: UITableViewController {
    
//    var salon = Salon()
    
    @IBOutlet weak var organizationNameLabel: UILabel!
    @IBOutlet weak var profileDescriptionTextView: UITextView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var fullAddressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        salon = TestSalon1 // загрузка
        
        organizationNameLabel.text = salon.name
        profileDescriptionTextView.text = salon.description
        phoneNumberLabel.text = salon.phoneNumber
        cityLabel.text = salon.city
        fullAddressLabel.text = salon.adress
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        let addServiceVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddServiceInSalonProfile") as! ProfileAddNewServiceHatTableViewController
//
//        if segue.destination == addServiceVC {
//            addServiceVC.mastersList = salon.masters
//        }
//    }
}
