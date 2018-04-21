//
//  test data.swift
//  Scheduling
//
//  Created by macbook on 06.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import Foundation

// MARK: - SALON

let TestSalon1 = Salon( name: "Tattoo2000", phoneNumber: "8-800-555-35-35", nickname: "T2000", description: "Tattoo salon in Moscow. All types off tattoo.", city: "Москва", adress: "Бауманская 666, дом 4, строение 2.", services: [])

let Service1 = Service(name: "Пирсинг", description: "Пирсинг любой сложности. От прокола мочки уха до плоскостного пирсинга. Стаж наших мастеров от 3х лет", masters: [], priceFrom: "500", priceTo: "1200")

let Service2 = Service(name: "Художественная тату", description: "Наши мастера сделают тату в любом стиле: олдскул, акварель, трешполька и многое другое. Работа производится в полностью стерильных помещениях, все инструменты дезинфецируются в специальных камерах, а расходные материалы вскрываются при Вас.", masters: [], priceFrom: "2000", priceTo: "5000")

var NoteDate1Start = Date()
var NoteDate1End = Date()
var NoteDate2Start = Date()
var NoteDate2End = Date()
var NoteDate3Start = Date()
var NoteDate3End = Date()
var NoteDate4Start = Date()
var NoteDate4End = Date()
var NoteDate5Start = Date()
var NoteDate5End = Date()
var NoteDate6Start = Date()
var NoteDate6End = Date()


let MondayForKostyaTable = DayInTable(dayName: WeekDays[0], dayOff: false, timeFrom: "10:00", timeTo: "18:00")
let TuesdayForKostyaTable = DayInTable(dayName: WeekDays[1], dayOff: false, timeFrom: "10:00", timeTo: "18:00")
let WednesdayForKostyaTable = DayInTable(dayName: WeekDays[2], dayOff: false, timeFrom: "10:00", timeTo: "18:00")
let ThursdayForKostyaTable = DayInTable(dayName: WeekDays[3], dayOff: false, timeFrom: "10:00", timeTo: "18:00")
let FridayForKostyaTable = DayInTable(dayName: WeekDays[4], dayOff: false, timeFrom: "10:00", timeTo: "18:00")
let SaturdayForKostyaTable = DayInTable(dayName: WeekDays[5], dayOff: true, timeFrom: "", timeTo: "")
let SundayForKostyaTable = DayInTable(dayName: WeekDays[6], dayOff: true, timeFrom: "", timeTo: "")

let KostyaTimeTable = TimeTable(DaysInTable: [MondayForKostyaTable, TuesdayForKostyaTable, WednesdayForKostyaTable, ThursdayForKostyaTable, FridayForKostyaTable, SaturdayForKostyaTable, SundayForKostyaTable])

var MasterKostya = Master()

// MARK: - CLIENT

let Client1 = Client(name: "Ольга", phoneNumber: "8-888-88-88", appointments: [])
let Client1Appointment1 = ClientAppointment(salonName: TestSalon1.name, serviceName: TestSalon1.services[0].name, price: "1000", timeAndDate: "10:00, 04.05", telephoneNumberOfSalon: TestSalon1.phoneNumber, salonAdress: TestSalon1.adress)
// MARK: - ACCOUNT

let salonAccount = Account(login: "salon", password: "salon", profileType: .salon)
let clientAccount = Account(login: "client", password: "client", profileType: .client)
let viewAccount = Account(login: "", password: "", profileType: .view)

var users : [Account] = [salonAccount, clientAccount, viewAccount]

//var users: [String : String] = ["Test" : "Test", "":"", "client" : "client", "salon" : "salon" ]

