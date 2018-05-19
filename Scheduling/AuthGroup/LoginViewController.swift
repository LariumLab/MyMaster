//
//  LoginViewController.swift
//  Scheduling
//
//  Created by Виталий Рамазанов on 27.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
	
	@IBOutlet weak var password: UITextField!
	@IBOutlet weak var login: UITextField!
	@IBOutlet weak var testLabel: UILabel!

    
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginWithoutRegistration(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let TabBarC = storyboard.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
        let ViewProfileNavigationC = storyboard.instantiateViewController(withIdentifier: "ViewProfileNavigationController")
        TabBarC.viewControllers?.append(ViewProfileNavigationC)
        ViewProfileNavigationC.tabBarItem = UITabBarItem(title: "Профиль", image: #imageLiteral(resourceName: "profile") , tag: 2)
        loadData(acc: viewAccount)
        present(TabBarC, animated: false, completion: nil)
        testLabel.text = "OK"
    }
    
	@IBAction func signIn(_ sender: Any) {
//        if users[login.text!] != nil && users[login.text!] == password.text! {
//            testLabel.text = "OK"
//            let TabBarC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
//                present(TabBarC, animated: false, completion: nil)
//        }

        for user in users {
            if user.login == login.text && user.password == password.text {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let TabBarC = storyboard.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
                
                switch user.profileType{
                case .salon:
                    let SalonRequestsNavigationC = storyboard.instantiateViewController(withIdentifier: "SalonRequestsNavigationController")
                    TabBarC.viewControllers?.append(SalonRequestsNavigationC)
                    SalonRequestsNavigationC.tabBarItem = UITabBarItem(title: "Заявки", image: #imageLiteral(resourceName: "requests") , tag: 2)
                    let SalonProfileNavigationC = storyboard.instantiateViewController(withIdentifier: "SalonNavigationController") as! UINavigationController
                TabBarC.viewControllers?.append(SalonProfileNavigationC)
                    SalonProfileNavigationC.tabBarItem = UITabBarItem(title: "Профиль", image: #imageLiteral(resourceName: "profile"), tag: 3)
                case .client:
                    let ClientProfileNavigationC = storyboard.instantiateViewController(withIdentifier: "ClientNavigationController")
                    TabBarC.viewControllers?.append(ClientProfileNavigationC)
                    ClientProfileNavigationC.tabBarItem = UITabBarItem(title: "Профиль", image: #imageLiteral(resourceName: "profile"), tag: 3)
                case .view:
                    let ViewProfileNavigationC = storyboard.instantiateViewController(withIdentifier: "ViewProfileNavigationController")
                    TabBarC.viewControllers?.append(ViewProfileNavigationC)
                    ViewProfileNavigationC.tabBarItem = UITabBarItem(title: "Профиль", image: #imageLiteral(resourceName: "profile") , tag: 2)
                }
                loadData(acc: user)
                
                // ========
                let searchNavigationC = TabBarC.viewControllers?.first as! UINavigationController
                let searchVC = searchNavigationC.viewControllers.first as! SearchTableViewController
                guard  let URLGetCityList = URL(string: serverAdr + "api/getCityList") else { return }
                URLSession.shared.dataTask(with: URLGetCityList) { (data, response, error) in
                    guard let data = data else { return }
                    do {
                        let citiesData = try JSONDecoder().decode([String].self, from: data)
                        cities = citiesData
                        DispatchQueue.main.async {
                            searchVC.tableView.reloadData()
                        }
                    } catch let err {
                        print(err)
                    }
                    }.resume()
                // ========
                
                present(TabBarC, animated: false, completion: nil)
                testLabel.text = "OK"
            }
            else {
                testLabel.text = "Fail"
            }
        }
	}
    
    
	/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
