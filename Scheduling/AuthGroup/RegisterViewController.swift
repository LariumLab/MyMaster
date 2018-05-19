//
//  RegisterViewController.swift
//  Scheduling
//
//  Created by Виталий Рамазанов on 27.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
	@IBOutlet weak var login: UITextField!
	
	@IBOutlet weak var password: UITextField!
	
	@IBOutlet weak var passwordConfirmation: UITextField!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func signUpButtonPresed(_ sender: Any) {
//        if (users[login.text!] == nil && (password.text! == passwordConfirmation.text!)) {
//            users[login.text!] = password.text!
//        }
		if login.text!.isValid(regex: .phone) {
			if password.text == passwordConfirmation.text {
				//SEND REQ TO SERV AND GET TOKEN
			} else {
				//PASSWORD ARE NOT EQUAL TO PASSCONFIRNATION
				let alert = UIAlertController(title: "Пароли не совпадают", message: "Проверьте правильность ввода пароля", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
				self.present(alert, animated: true)
			}
		} else {
			// PHONE IS NOT PHONE
			let alert = UIAlertController(title: "Неправильный номер", message: "Проверьте правильность ввода номера телефона", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
			self.present(alert, animated: true)
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
