//
//  SearchScheduleOfMasterPageViewController.swift
//  Scheduling
//
//  Created by macbook on 13.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class SearchScheduleOfMasterPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    // MARK - Инициализация извне
    var master = Master()
    var serviceName = ""
    var firstWeekStartOn = Date()
    
    // MARK - Инизиализация внутри
    var pages : [ScheduleTableViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        pages = pagesInit(forMaster: master, numberOfWeeksToCreate: 4, firstWeekStartOn: firstWeekStartOn)
        self.setViewControllers([ pages[0] ], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
        
//        if profileType == ProfileType.client {
            let AddItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addRequest))
            self.navigationItem.rightBarButtonItem = AddItem
//        }
    }
    
    @objc func addRequest() {
        let addRequestTableVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchCreateRequest") as! CreateRequestTableViewController
        addRequestTableVC.master = master
        addRequestTableVC.serviceName = serviceName
        self.navigationController?.viewControllers.append(addRequestTableVC)
        self.navigationItem.backBarButtonItem?.title = "Отмена"
    }

    func pagesInit(forMaster master: Master, numberOfWeeksToCreate: Int, firstWeekStartOn: Date) -> [ScheduleTableViewController] {
        var ScheduleVector : [ScheduleTableViewController] = []
        let calendar = Calendar.current
        var currentWeekStartOn = firstWeekStartOn
        
        for _ in 1...numberOfWeeksToCreate{
            let schedule = ScheduleTableViewController()
            schedule.WeekStartOn = currentWeekStartOn
            schedule.master = master
//            schedule.master.appointments = master.appointments
//            schedule.master.timeTable = master.timeTable
            ScheduleVector.append(schedule)
            currentWeekStartOn = calendar.date(byAdding: .day, value: 7, to: currentWeekStartOn)!
        }
        return ScheduleVector
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        let currentIndex : Int = pages.index(of: viewController as! ScheduleTableViewController)!
        if (currentIndex <= 0) {
            return nil
        }
        return pages[ currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        let currentIndex : Int = pages.index(of: viewController as! ScheduleTableViewController)!
        if (currentIndex >= pages.count - 1) {
            return nil
        }
    return pages[ currentIndex + 1 ]
    }

}
