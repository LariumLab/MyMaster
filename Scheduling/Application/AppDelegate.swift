//
//  AppDelegate.swift
//  Scheduling
//
//  Created by macbook on 24.02.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
	
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")! as TimeZone

        NoteDate1Start = formatter.date(from: "16.04.2018 12:00")!
        NoteDate1End = formatter.date(from: "16.04.2018 13:30")!
        NoteDate2Start = formatter.date(from: "16.04.2018 16:00")!
        NoteDate2End = formatter.date(from: "16.04.2018 17:00")!
        NoteDate3Start = formatter.date(from: "17.04.2018 14:00")!
        NoteDate3End = formatter.date(from: "17.04.2018 16:00")!
        NoteDate4Start = formatter.date(from: "18.04.2018 11:00")!
        NoteDate4End = formatter.date(from: "18.04.2018 11:30")!
        NoteDate5Start = formatter.date(from: "19.04.2018 13:15")!
        NoteDate5End = formatter.date(from: "19.04.2018 14:45")!
        NoteDate6Start = formatter.date(from: "20.04.2018 15:10")!
        NoteDate6End = formatter.date(from: "20.04.2018 16:40")!

        let NoteInTable1 = NoteInTable(dateFrom: NoteDate1Start, dateTo: NoteDate1End)
        let NoteInTable2 = NoteInTable(dateFrom: NoteDate2Start, dateTo: NoteDate2End)
        let NoteInTable3 = NoteInTable(dateFrom: NoteDate3Start, dateTo: NoteDate3End)
        let NoteInTable4 = NoteInTable(dateFrom: NoteDate4Start, dateTo: NoteDate4End)
        let NoteInTable5 = NoteInTable(dateFrom: NoteDate5Start, dateTo: NoteDate5End)
        let NoteInTable6 = NoteInTable(dateFrom: NoteDate6Start, dateTo: NoteDate6End)
        
        MasterKostya = Master(name: "Костя", timeTable: KostyaTimeTable, appointments: [NoteInTable1, NoteInTable2, NoteInTable3, NoteInTable4, NoteInTable5, NoteInTable6])
        
        TestSalon1.addService(service: Service1)
        TestSalon1.addService(service: Service2)
        TestSalon1.addMasterToMastersList(master: MasterKostya)
        Service1.addMaster(master: MasterKostya)
        
        cities.append(TestSalon1.city)
        nicknames.append(TestSalon1.nickname)
        Client1.appointments.append(Client1Appointment1)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

