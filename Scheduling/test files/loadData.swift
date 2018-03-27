//
//  loadData.swift
//  Scheduling
//
//  Created by macbook on 19.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import Foundation


// MARK: - Salon data if profileType == true
var salon = Salon()
var servicesList : [Service] = []
var mastersList : [Master] = []

// MARK: - CLient data if profileType == false
var client = Client()

// MARK: - loading data

func loadData(profileType : Bool){
    if profileType == true {
        salon = TestSalon1  // ЗАГРУЗКА
        servicesList = salon.services
        mastersList = salon.masters
            }
    else {
        
    }
}
