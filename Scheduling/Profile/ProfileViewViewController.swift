//
//  ProfileViewViewController.swift
//  Scheduling
//
//  Created by macbook on 24.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class ProfileViewViewController: UIViewController {

    @IBAction func signIn(_ sender: Any) {
    
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNavigationC = storyboard.instantiateViewController(withIdentifier: "LoginNavigationC") as! UINavigationController
        let tabBar = storyboard.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
        _ = Keychain._delete(key: "userToken")
        tabBar.viewControllers?.removeAll()
        self.dismiss(animated: false, completion: nil)
        present(loginNavigationC, animated: true, completion: nil)
    }
    
    @IBAction func register(_ sender: Any) {
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
