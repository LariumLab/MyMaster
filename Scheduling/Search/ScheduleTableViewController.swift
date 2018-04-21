//
//  ScheduleTableViewController.swift
//  Scheduling
//
//  Created by macbook on 14.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class ScheduleTableViewController: UITableViewController {

    var timeTable = KostyaTimeTable
    var MastersAppointmentsInThisWeek : [NoteInTable] = []
    var WeekStartOn = Date()
    var infoForDays : [ (Double, Date) ] = [] // раб.часы для каждого дня 0...6 и дата дня (dd.MM)
    var sectionHeight : CGFloat = 0
    
    var appointmentsByDayVector : [[NoteInTable]] = []
    
    let WeekDescriptionCellIdentifier = "weekDescriptionCell"
    let WorkDayDescriptionCellIdentifier = "dayDescriptionCell"
    let TimeCellIdentifier = "timeCell"
    let NameLabelCellIdentifier = "nameLabelCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "WeekDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: WeekDescriptionCellIdentifier)
        tableView.register(UINib(nibName: "WorkDayDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: WorkDayDescriptionCellIdentifier)
        tableView.register(UINib(nibName: "ScheduleTimeTableViewCell", bundle: nil), forCellReuseIdentifier: TimeCellIdentifier)
        tableView.register(UINib(nibName: "NameLabelTableViewCell", bundle: nil), forCellReuseIdentifier: NameLabelCellIdentifier)
        sectionHeight = 28
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")! as TimeZone
        WeekStartOn = formatter.date(from: "16.04.2018")!
        infoForDays = setInfoForDays()
        
        MastersAppointmentsInThisWeek = getMastersAppointmentsForWeek(weekStart: WeekStartOn, fromMaster: MasterKostya)
        appointmentsByDayVector = getAppointmentsByDaysVector(mastersAppointmentsInWeek: MastersAppointmentsInThisWeek)
    }

    func getMastersAppointmentsForWeek(weekStart startDay: Date, fromMaster master: Master) -> [NoteInTable] {
        var appointmentsInWeekVector : [NoteInTable] = []
        let calendar = Calendar.current
        let EndDay = calendar.date(byAdding: .day, value: 7, to: startDay)
        for appointment in master.appointments {
            
            if appointment.DateFrom >= startDay && appointment.DateFrom <= EndDay! {
                appointmentsInWeekVector.append(appointment)
            }
        }
        appointmentsInWeekVector.sort(by: { $0.DateFrom < $1.DateFrom})
        return appointmentsInWeekVector
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setAppointmentsViews()
    }
    
    func setInfoForDays() -> [ (Double, Date) ] {
        var vector : [ (Double, Date) ] = []
        let calendar = Calendar(identifier: .gregorian)
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")! as TimeZone
        var date : Date = WeekStartOn
    
        for day in timeTable.DaysInTable {
            let currentInterval : Double
            
            if day.dayOff == false {
                let start : String = day.timeFrom
                let end : String = day.timeTo
                formatter.dateFormat = "HH:mm"
                let startDate = formatter.date(from: start)
                let endDate = formatter.date(from: end)
                currentInterval = (endDate?.timeIntervalSince(startDate!))! / 60 / 60
            }
            else {
                currentInterval = 0
            }
            vector.append( (currentInterval, date) )
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        }
        return vector
    }
    
    
    func getAppointmentsByDaysVector(mastersAppointmentsInWeek appointments : [NoteInTable]) -> [ [NoteInTable] ] {
        var vector : [[NoteInTable]] = [ [], [], [], [], [], [], [] ]
        let calendar = Calendar.current
        
        for appointment in appointments {
            let appointmentDay = calendar.dateComponents([.day], from: appointment.DateFrom)
            
            var dayIndex = 0
            for dayInfo in infoForDays {
                let dayDay = calendar.dateComponents([.day], from: dayInfo.1)
                if appointmentDay == dayDay {
                    vector[dayIndex].append(appointment)
                    break
                }
                dayIndex = dayIndex + 1
            }
        }
        return vector
    }
    
    func setAppointmentsViews() {
//        let sectionHeight = CGFloat(28)
        let weekDescriptionCell = WeekDescriptionTableViewCell()
        let weekDescriptionHeight = weekDescriptionCell.cellHeight
        let dayDescriptionCell = WorkDayDescriptionTableViewCell()
        let dayDescriptionHeight = dayDescriptionCell.cellHeight
        let timecell = ScheduleTimeTableViewCell()
        let timeHeight = timecell.CellHeight
        let nameLabelCell = NameLabelTableViewCell()
        let nameLabelHeight = nameLabelCell.cellHeight
        
        let daysInTable = timeTable.DaysInTable
        var dayIndex = 0
        var CellsHeightsSumBeforeCurrentSection : CGFloat = weekDescriptionHeight
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")! as TimeZone

        for day in daysInTable {
            if day.dayOff == true {
                CellsHeightsSumBeforeCurrentSection += nameLabelHeight + sectionHeight
            }
            else{
                CellsHeightsSumBeforeCurrentSection += dayDescriptionHeight + sectionHeight
            }
            
            let appointmentsInDay : [NoteInTable] = appointmentsByDayVector[dayIndex]

            for appoitment in appointmentsInDay {
                let appointmentStart  = appoitment.DateFrom
                let appointmentEnd  = appoitment.DateTo
                let workDayStart : String = day.timeFrom
                let workDayStartFormatterDate = formatter.date(from: workDayStart)
                
                let appointmentStartInString = formatter.string(from: appointmentStart)
                let appointmentStartFormatterDate = formatter.date(from: appointmentStartInString)
                
                let AppointmentHeight = (appointmentEnd.timeIntervalSince(appointmentStart)) / 60
                let CurrentAppoitmentY = (appointmentStartFormatterDate?.timeIntervalSince(workDayStartFormatterDate!))! / 60
                let y = CellsHeightsSumBeforeCurrentSection + CGFloat(CurrentAppoitmentY)
                
                let AppointmentView = UIView(frame: CGRect(
                    x: CGFloat(0),
                    y: y,
                    width: UIScreen.main.bounds.width,
                    height: CGFloat(AppointmentHeight) ))
                tableView.addSubview(AppointmentView)
                AppointmentView.backgroundColor = UIColor(red:0.20, green:0.72, blue:0.55, alpha:0.7)
            }
            
            CellsHeightsSumBeforeCurrentSection += CGFloat(infoForDays[dayIndex].0) * timeHeight
            dayIndex += 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + WeekDays.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        }
        else {
            return WeekDays[section-1]
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if section > 0 {
            view.tintColor = UIColor(red:1.00, green:0.51, blue:0.06, alpha:1.0)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            let weekDescrCell = WeekDescriptionTableViewCell()
            return weekDescrCell.cellHeight
        }
        
        if indexPath.row == 0 {
            if timeTable.DaysInTable[indexPath.section-1].dayOff == false {
                let DayDescr = WorkDayDescriptionTableViewCell()
                return DayDescr.cellHeight
            }
            else {
                let NameLabelCell = NameLabelTableViewCell()
                return NameLabelCell.cellHeight
            }
        }
        else {
            let timeCell = ScheduleTimeTableViewCell()
            return timeCell.CellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1...(WeekDays.count):
            return Int(infoForDays[section-1].0) + 1 // количичество рабочих часов в день
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")! as TimeZone

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: WeekDescriptionCellIdentifier, for: indexPath) as! WeekDescriptionTableViewCell
            let weekStartString = formatter.string(from: WeekStartOn)
            let weekEndDate = Calendar.current.date(byAdding: .day, value: 6, to: WeekStartOn)
            let weekEndString = formatter.string(from: weekEndDate!)
            cell.weekDateLabel.text = "Неделя: " + weekStartString + " - " + weekEndString
            return cell
        }
        
        let currentDay = timeTable.DaysInTable[indexPath.section-1]

        if indexPath.row == 0 {
            if currentDay.dayOff == false {
                let cell = tableView.dequeueReusableCell(withIdentifier: WorkDayDescriptionCellIdentifier, for: indexPath) as! WorkDayDescriptionTableViewCell
                cell.timeFromLabel.text = currentDay.timeFrom
                cell.timeToLabel.text = currentDay.timeTo
                cell.appointmentsNumberLabel.text = String(appointmentsByDayVector[indexPath.section-1].count)
                let dayDateString = formatter.string(from: infoForDays[indexPath.section-1].1)
                cell.dayDateLabel.text = dayDateString
                return cell
            }
            else {
               let cell = tableView.dequeueReusableCell(withIdentifier: NameLabelCellIdentifier, for: indexPath) as! NameLabelTableViewCell
                cell.nameLabel.text = "Выходной"
                cell.backgroundColor = UIColor(ciColor: .red)
                return cell
            }
        }
        
        formatter.dateFormat = "HH:mm"
        let dayStartString : String = timeTable.DaysInTable[indexPath.section-1].timeFrom
        let dayStartDate = formatter.date(from: dayStartString)
        let timeForCell = Calendar.current.date(byAdding: .hour, value: ( indexPath.row - 1 ), to: dayStartDate!)
        let cell = tableView.dequeueReusableCell(withIdentifier: TimeCellIdentifier, for: indexPath) as! ScheduleTimeTableViewCell
        cell.timeLabel.text = formatter.string(from: timeForCell!)
        return cell
    }
    
}
