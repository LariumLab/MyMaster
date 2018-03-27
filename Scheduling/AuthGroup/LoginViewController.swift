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
    
	@IBAction func signIn(_ sender: Any) {
		if users[login.text!] != nil && users[login.text!] == password.text! {
			testLabel.text = "OK"
		} else {
			testLabel.text = "Fail"
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
