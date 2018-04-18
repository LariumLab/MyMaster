//
//  SearchScheduleOfMasterPageViewController.swift
//  Scheduling
//
//  Created by macbook on 13.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class SearchScheduleOfMasterPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

//    var currentIndex : Int = 0
    var pages : [UITableViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
//        let TVC1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchSalonsInCityTable") as! SearchSalonsInCityTableViewController
//        TVC1.salonsInSity = [ ("1", "1"), ("2", "2"), ("3", "3"), ("4", "4")]
//        let TVC2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchSalonsInCityTable") as! SearchSalonsInCityTableViewController
//        TVC2.salonsInSity = [ ("a", "a"), ("b", "b"), ("c", "c"), ("d", "d")]
//        let TVC3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchSalonsInCityTable") as! SearchSalonsInCityTableViewController
//        TVC3.salonsInSity = [ ("]]]]", "[[[[["), ("((((((((", ")))))"), ("+++", "+++"), ("----", "-----")]
//        pages = [TVC1, TVC2, TVC3]
        
        self.setViewControllers([ pages[0] ], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        let currentIndex : Int = pages.index(of: viewController as! SearchSalonsInCityTableViewController)!
        if (currentIndex <= 0) {
            return nil
        }
        return pages[ currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        let currentIndex : Int = pages.index(of: viewController as! SearchSalonsInCityTableViewController)!
        if (currentIndex >= pages.count - 1) {
            return nil
        }
    return pages[ currentIndex + 1 ]
    }

    // page indicator
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return pages.count
//    }

}
