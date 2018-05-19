//
//  InitialViewController.swift
//  Scheduling
//
//  Created by Виталий Рамазанов on 21.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit


class InitialViewController: UIViewController {
	
	var token: SecKey!
    var TabBar: UIViewController = UIViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.showBlurLoader()

		//Зачем это здесь?
        //**********************************************************************************************************//
        
//        let searchVC = UIStoryboard.init(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchCities") as! SearchTableViewController
//        guard  let URLGetCityList = URL(string: serverAdr + "api/getCityList") else { return }
//        URLSession.shared.dataTask(with: URLGetCityList) { (data, response, error) in
//            guard let data = data else { return }
//            do {
//                let citiesData = try JSONDecoder().decode([String].self, from: data)
//                cities = citiesData
//                searchVC.tableView.reloadData()
//            } catch let err {
//                print(err)
//            }
//            }.resume()
//        
        //**********************************************************************************************************//
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
		DispatchQueue.global(qos: .userInitiated).async {
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			let TabBarC = storyboard.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
			
			// Adding user's token to keychain (if needed)
			
			let token = Keychain.load(key: "userToken")
			if token != nil {
				
			} else {
				let key: String = "userToken"
				let data = "testtoken".data(using: .utf8)!
				
				
				if Keychain.save(key: key, data: data)  == errSecSuccess {
					print("tokenAdded")
				}
			}
			
			
            
			// Now we are checking, if there is some user's token in keychain
			// if true, we can determine the type of account and then we can present appropriate tabbar

            // =========================
            // Проблема с удалением токена - keychain._delete - не работает
            //            let token = Keychain.load(key: "userToken")
            //var token = Keychain.load(key: "userToken")
            //token = nil
            // =========================
            
			if token != nil {
				// отправка запроса
                // то, что ниже - временно
//                let ClientProfileNavigationC = storyboard.instantiateViewController(withIdentifier: "ClientNavigationController")
//                TabBarC.viewControllers?.append(ClientProfileNavigationC)
				let user = Account(login: "client", password: "client", profileType: .client)
				loadData(acc: user)
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
                self.TabBar = TabBarC
                self.present(self.TabBar, animated: false, completion: nil)
                
			} else { // else we can present the registration view
				
                let registrationNavigationC = storyboard.instantiateViewController(withIdentifier: "LoginNavigationC") as! UINavigationController
                self.present(registrationNavigationC, animated: false, completion: nil)
			}
			//        present(TabBarC, animated: true, completion: nil)
//            self.TabBar = TabBarC
//            sleep(1)
//            DispatchQueue.main.async {
//                self.view.removeBlurLoader()
//            }
//            self.present(self.TabBar, animated: false, completion: nil)
		}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
