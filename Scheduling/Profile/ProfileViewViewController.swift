//
//  ProfileViewViewController.swift
//  Scheduling
//
//  Created by macbook on 24.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class ProfileViewViewController: UIViewController {
    
    var loginVC : LoginViewController?
    
    @IBAction func signIn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBar = storyboard.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
//        let debug = Keychain.delete(key: "userToken")
//        print(debug)
        tabBar.viewControllers?.removeAll()
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func register(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBar = storyboard.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
        tabBar.viewControllers?.removeAll()
        self.dismiss(animated: false, completion: nil)
        guard loginVC != nil else {return}
        loginVC!.showRegisterController = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
