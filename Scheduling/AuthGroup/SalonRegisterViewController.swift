//
//  SalonRegisterViewController.swift
//  Scheduling
//
//  Created by Виталий Рамазанов on 09.05.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class SalonRegisterViewController: UIViewController {

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
    
	@IBAction func signUpButtonPressed(_ sender: Any) {
		let loginText: String = login.text!
		let passText: String = password.text!
		let passConfirmText: String = passwordConfirmation.text!
		if loginText != "" && (passText == passConfirmText) && passText != "" {
			guard let URLRegisterSalon = URL(string: serverAdr + "api/salon/signUp?\(loginText)&\(passText)") else { return }
			URLSession.shared.dataTask(with: URLRegisterSalon) { (data, response, error) in
				guard let data = data else { return }
				print(Keychain.save(key: "userToken", data: data))
			}
		} else {
			let alert = UIAlertController(title: "Пароли не совпадают", message: "Проверьте правильность ввода пароля", preferredStyle: .alert)
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
