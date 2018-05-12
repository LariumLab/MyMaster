//
//  test classes.swift
//  Scheduling
//
//  Created by macbook on 06.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import Foundation
import UIKit

struct blueGamma {
//    let whiteColor = UIColor(red:0.93, green:0.93, blue:0.92, alpha:1.0)
//    let whiteColor = UIColor(red:1.00, green:0.96, blue:0.94, alpha:1.0)
//    let whiteColor = UIColor(red:1.00, green:0.98, blue:0.98, alpha:1.0)
    let whiteColor = UIColor(red:1.00, green:1.00, blue:0.98, alpha:1.0)
    let skyBlue = UIColor(red:0.78, green:0.95, blue:0.95, alpha:0.8)
//    let biegeColor = UIColor(red:0.95, green:0.86, blue:0.80, alpha:1.0)
    let biegeColor = UIColor(red:1.00, green:0.96, blue:0.94, alpha:1.0)
    let lightBlue = UIColor(red:0.57, green:0.78, blue:0.76, alpha:1.0)
    let mediumBlue = UIColor(red:0.27, green:0.70, blue:0.71, alpha:1.0)
    let darkBlue = UIColor(red:0.07, green:0.19, blue:0.27, alpha:1.0)
    
    
    func makeViewStyle(view: UIView, color: UIColor, radius: CGFloat) {
        view.backgroundColor = color
        view.layer.cornerRadius = radius
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
    }
}

struct seaGamma {
    let darkColor = UIColor(red:0.30, green:0.43, blue:0.50, alpha:1.0)
    let darkGreen = UIColor(red:0.37, green:0.50, blue:0.54, alpha:1.0)
    let mediumGreen = UIColor(red:0.43, green:0.58, blue:0.59, alpha:1.0)
    let brown = UIColor(red:0.60, green:0.55, blue:0.56, alpha:1.0)
    let darkBiege = UIColor(red:0.78, green:0.70, blue:0.65, alpha:1.0)
    let mediumBiege = UIColor(red:0.85, green:0.78, blue:0.71, alpha:1.0)
    let lightBiege = UIColor(red:0.93, green:0.87, blue:0.81, alpha:1.0)
}

enum ProfileType {
    case salon
    case client
    case view
}

class Account{

    var login : String
    var password : String
    var profileType : ProfileType
    
    init(login: String, password: String, profileType: ProfileType) {
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
    var ID : String
    
    init(name: String, phoneNumber: String, nickname: String, description: String, city: String, adress: String, services: [Service], ID : String) {
        self.nickname = nickname
        self.description = description
        self.city = city
        self.adress = adress
        self.services = services
        self.ID = ID
        super.init(name: name, phoneNumber: phoneNumber)
    }
    
    override init(){
        nickname = ""
        description = ""
        city = ""
        adress = ""
        services = []
        ID = ""
        super.init()
    }
    
    func addService(service: Service){
        self.services.append(service)
    }
    
    func addMasterToMastersList(master: Master){
        masters.append(master)
    }
    
}

struct SalonPreview: Codable{
    let customName: String
    let address: String
    let ID: UUID
}

struct SalonInfo: Codable{
    let nickName: String
    let phoneNumber: String
    let description: String
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
    var appointments : [NoteInTable]

    init(name: String, timeTable: TimeTable, appointments: [NoteInTable]) {
        self.name = name
        self.timeTable = timeTable
        self.appointments = appointments
    }
    
    init() {
        name = ""
        timeTable = TimeTable()
        appointments = []
    }
    
    func addAppointment(appointment: NoteInTable){
        self.appointments.append(appointment)
    }
}

class NoteInTable : Equatable{
    var DateFrom : Date
    var DateTo : Date
    
    init(dateFrom : Date, dateTo : Date ) {
        self.DateFrom = dateFrom
        self.DateTo = dateTo
    }
    
    static func == (l: NoteInTable, r: NoteInTable) -> Bool {
        return l.DateFrom == r.DateFrom && l.DateTo == r.DateTo
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

var WeekDays = [ "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]

class DayInTable : Equatable{
    var dayName : String // from WeekDays[]
    var dayOff : Bool // выходной
    var timeFrom : String
    var timeTo : String
    
    init(dayName : String, dayOff : Bool, timeFrom : String, timeTo : String) {
        self.dayName = dayName
        self.dayOff = dayOff
        self.timeFrom = timeFrom
        self.timeTo = timeTo
    }
    
    static func == (l: DayInTable, r: DayInTable) -> Bool{
        return l.dayName == r.dayName &&
               l.dayOff == r.dayOff &&
               l.timeFrom == r.timeFrom &&
               l.timeTo == r.timeTo
    }
}

class SalonRequest {
    var client : Client
    var serviceName : String
    var master : Master
    var time : Date
    var description : String
    
    init(client: Client, serviceName: String, master: Master, time: Date, description: String) {
        self.client = client
        self.serviceName = serviceName
        self.master = master
        self.time = time
        self.description = description
    }
}
