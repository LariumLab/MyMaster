//
//  loadData.swift
//  Scheduling
//
//  Created by macbook on 19.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import Foundation

let dynamicIP = "192.168.0.104"
let serverAdr = "http://" + dynamicIP + ":8080/"
let viewAccount = Account(login: "", password: "", profileType: .view)
// MARK: - Common data
var profileType : ProfileType? = nil
var nicknames : [String] = []
var salons : [Salon] = []
var cities : [String] = [] // необходимо добавить удаление повторяющихся городов

// MARK: - Salon data if profileType == true
var salon = Salon()
//var servicesList : [Service] = []
//var mastersList : [Master] = []

// MARK: - CLient data if profileType == false
var client = Client()

// MARK: - loading data

func loadData(acc: Account){
    
    switch acc.profileType {
    case .salon:
        salon = TestSalon1  // ЗАГРУЗКА - запрос логин/пароль, ответ - салон
//        servicesList = salon.services
//        mastersList = salon.masters
        profileType = ProfileType.salon
    case .client:
        client = Client1 // аналогично
        profileType = ProfileType.client
    case .view:
        profileType = ProfileType.view
    }
}
