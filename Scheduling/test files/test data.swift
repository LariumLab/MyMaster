//
//  test data.swift
//  Scheduling
//
//  Created by macbook on 06.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import Foundation

var profileType : Bool = true

let TestSalon1 = Salon(nickname: "T2000", name: "Tattoo2000", phoneNumber: "8-800-555-35-35", description: "Tattoo salon in Moscow. All types off tattoo.", city: "Москва", adress: "Бауманская 666, дом 4, строение 2.", services: [])

//var mastersOfSalon1 : [Master] = []
//var mastersOfSalon2 : [Master] = []

let Service1 = Service(name: "Пирсинг", description: "Пирсинг любой сложности. От прокола мочки уха до плоскостного пирсинга. Стаж наших мастеров от 3х лет", masters: [], priceFrom: "500", priceTo: "1200")

let Service2 = Service(name: "Художественная тату", description: "Наши мастера сделают тату в любом стиле: олдскул, акварель, трешполька и многое другое. Работа производится в полностью стерильных помещениях, все инструменты дезинфецируются в специальных камерах, а расходные материалы вскрываются при Вас.", masters: [], priceFrom: "2000", priceTo: "5000")

let NoteInTable1 = NoteInTable(timeFrom: "12:00", timeTo: "13:00")
let NoteInTable2 = NoteInTable(timeFrom: "13:15", timeTo: "15:00")
let NoteInTable3 = NoteInTable(timeFrom: "16:30", timeTo: "17:30")

let MondayForKostyaTable = DayInTable(dayName: WeekDays[0], dayOff: false, timeFrom: "10:00", timeTo: "18:00", appointments: [])
let TuesdayForKostyaTable = DayInTable(dayName: WeekDays[1], dayOff: false, timeFrom: "10:00", timeTo: "18:00", appointments: [])
let WednesdayForKostyaTable = DayInTable(dayName: WeekDays[2], dayOff: false, timeFrom: "10:00", timeTo: "18:00", appointments: [])
let ThursdayForKostyaTable = DayInTable(dayName: WeekDays[3], dayOff: false, timeFrom: "10:00", timeTo: "18:00", appointments: [])
let FridayForKostyaTable = DayInTable(dayName: WeekDays[4], dayOff: false, timeFrom: "10:00", timeTo: "18:00", appointments: [])
let SaturdayForKostyaTable = DayInTable(dayName: WeekDays[5], dayOff: true, timeFrom: "", timeTo: "", appointments: [])
let SundayForKostyaTable = DayInTable(dayName: WeekDays[6], dayOff: true, timeFrom: "", timeTo: "", appointments: [])

//MondayForKostyaTable.addAppointment(appointment: NoteInTable1)
//TuesdayForKostyaTable.addAppointment(appointment: NoteInTable2)
//ThursdayForKostyaTable.addAppointment(appointment: NoteInTable3)

let KostyaTimeTable = TimeTable(DaysInTable: [MondayForKostyaTable, TuesdayForKostyaTable])

let MasterKostya = Master(name: "Костя", timeTable: KostyaTimeTable)

//TestSalon1.addService(service: Service1)
//Service1.addMaster(master: MasterKostya)
var users: [String : String] = ["Test" : "Test"]

