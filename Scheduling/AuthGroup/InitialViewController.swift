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

    override func viewDidLoad() {
        super.viewDidLoad()
		
		// if true, we can determine the type of account and then we can present appropriate tabbar
		if getTokenFromKeychain() {
			// TODO
		} else { // else we can present the registration view
			// TODO:
		}
        // Do any additional setup after loading the view.
    }
	
	//This function receives token from phone's keychain and puts it into token (up!)
	func getTokenFromKeychain() -> Bool {
		var item: CFTypeRef?
		let getquery: [String: Any] = [kSecClass as String: kSecClassKey,
									   kSecAttrApplicationTag as String: appTag,
									   kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
									   kSecReturnRef as String: true]
		let status = SecItemCopyMatching(getquery as CFDictionary, &item)
		
		if status == errSecSuccess {
			token = item as! SecKey
			return true
		} else {
			return false
		}
		
	}

	//This function adds token ("key" in function's body) to keychain
	func addTokenToKeychain() -> Bool {
		let key = "TOKEN"
		let addquery: [String: Any] = [kSecClass as String: kSecClassKey,
									   kSecAttrApplicationTag as String: appTag,
									   kSecValueRef as String: key]
		
		let status = SecItemAdd(addquery as CFDictionary, nil)
		return status == errSecSuccess
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
