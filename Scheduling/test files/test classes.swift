//
//  test classes.swift
//  Scheduling
//
//  Created by macbook on 06.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import Foundation

var cities : [String] = [] // необходимо добавить удаление повторяющихся городов

class Account{
    var login : String
    var password : String
    var profileType : Bool
    
    init(login: String, password: String, profileType: Bool) {
        self.login = login
        self.password = password
        self.profileType = profileType
    }
}

class Profile{
    var name : String
    var phoneNumber: String
    
    init(name: String, phoneNumber: String) {
        self.name = name
        self.phoneNumber = phoneNumber
    }
    
    init() {
        name = ""
        phoneNumber = ""
    }
}

class Salon : Profile{
    var nickname : String
    var description: String
    var city: String
    var adress: String
    var services : [Service]
    var masters : [Master] = []
    
    init(name: String, phoneNumber: String, nickname: String, description: String, city: String, adress: String, services: [Service]) {
        self.nickname = nickname
        self.description = description
        self.city = city
        self.adress = adress
        self.services = services
        super.init(name: name, phoneNumber: phoneNumber)
    }
    
    override init(){
        nickname = ""
        description = ""
        city = ""
        adress = ""
        services = []
        super.init()
    }
    
    func addService(service: Service){
        self.services.append(service)
    }
    
    func addMasterToMastersList(master: Master){
        masters.append(master)
    }
    
}

class Client: Profile{
    var appointments: [ClientAppointment]
    
    init(name: String, phoneNumber: String, appointments: [ClientAppointment]) {
        self.appointments = appointments
        super.init(name: name, phoneNumber: phoneNumber)
    }
    
    override init() {
        appointments = []
        super.init()
    }
    
    func addAppointment(appointment: ClientAppointment){
        self.appointments.append(appointment)
    }
}

class Service{
    var name : String
    var description: String
    var masters : [Master]
    var priceFrom : String
    var priceTo : String
    
    init(name: String, description: String, masters: [Master], priceFrom : String, priceTo : String) {
        self.name = name
        self.description = description
        self.masters = masters
        self.priceFrom = priceFrom
        self.priceTo = priceTo
    }
    
    init() {
        name = ""
        description = ""
        masters = []
        priceFrom = ""
        priceTo = ""
    }
    
    func addMaster(master: Master){
        self.masters.append(master)
    }
}

class ClientAppointment{
    var salonName : String
    var serviceName : String
    var price : String
    var timeAndDate : String // or : date? hh:mm dd (число)
    var telephoneNumberOfSalon : String
    var salonAdress : String
    
    init(salonName : String, serviceName: String, price: String, timeAndDate: String, telephoneNumberOfSalon : String, salonAdress: String) {
        self.salonName = salonName
        self.serviceName = serviceName
        self.price = price
        self.timeAndDate = timeAndDate
        self.telephoneNumberOfSalon = telephoneNumberOfSalon
        self.salonAdress = salonAdress
    }
}

class Master{
    var name : String
    var timeTable : TimeTable

    init(name: String, timeTable:TimeTable) {
        self.name = name
        self.timeTable = timeTable
    }
    
    init() {
        name = ""
        timeTable = TimeTable()
    }
}

class TimeTable{
    var DaysInTable : [DayInTable]
    
    init(DaysInTable: [DayInTable]) {
        self.DaysInTable = DaysInTable
    }
    
    init() {
        DaysInTable = []
    }
}

var WeekDays = [ "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

class DayInTable{
    var dayName : String // from WeekDays[]
    var dayOff : Bool // выходной
    var timeFrom : String
    var timeTo : String
    var appointments : [NoteInTable]
    
    init(dayName : String, dayOff : Bool, timeFrom : String, timeTo : String, appointments : [NoteInTable]) {
        self.dayName = dayName
        self.dayOff = dayOff
        self.timeFrom = timeFrom
        self.timeTo = timeTo
        self.appointments = appointments
    }
    
    func addAppointment(appointment: NoteInTable){
        self.appointments.append(appointment)
    }
}

class NoteInTable{
    var timeFrom : String
    var timeTo : String
    
    init(timeFrom : String, timeTo : String ) {
        self.timeFrom = timeFrom
        self.timeTo = timeTo
    }
}
