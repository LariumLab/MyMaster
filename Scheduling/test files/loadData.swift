//
//  loadData.swift
//  Scheduling
//
//  Created by macbook on 19.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import Foundation

// MARK: - Common data
var profileType : Bool = Bool() // true - салон, false - клиент
var nicknames : [String] = []
var salons : [Salon] = []
var cities : [String] = [] // необходимо добавить удаление повторяющихся городов

// MARK: - Salon data if profileType == true
var salon = Salon()
var servicesList : [Service] = []
var mastersList : [Master] = []

// MARK: - CLient data if profileType == false
var client = Client()

// MARK: - loading data

func loadData(acc: Account){
    if acc.profileType == true {
        salon = TestSalon1  // ЗАГРУЗКА - запрос логин/пароль, ответ - салон
        servicesList = salon.services
        mastersList = salon.masters
        profileType = true
            }
    else {
        client = Client1 // аналогично
        profileType = false
    }
}
