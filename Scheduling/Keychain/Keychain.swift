//
//  Keychain.swift
//  Scheduling
//
//  Created by Виталий Рамазанов on 23.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import Foundation

class Keychain {
	class func save(key: String, data: Data) -> OSStatus {
		let query = [
			kSecClass as String : kSecClassGenericPassword as String,
			kSecAttrAccount as String : key,
		kSecValueData as String : data] as [String : Any]
		SecItemDelete(query as CFDictionary)
		
		return SecItemAdd(query as CFDictionary, nil)
	}
	
	class func delete(key: String) -> OSStatus {
		let query = [kSecClass as String : kSecClassGenericPassword as String,
		kSecAttrAccount as String : key] as [String : Any]
		
		return SecItemDelete(query as CFDictionary)
	}
	
	class func _delete(key: String) -> OSStatus {
		let query = [
			kSecClass as String       : kSecClassGenericPassword,
			kSecAttrAccount as String : key,
			kSecReturnData as String  : kCFBooleanTrue,
			kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
		
		return SecItemDelete(query as CFDictionary)
	}
	
	class func load(key: String) -> Data? {
		let query = [
			kSecClass as String       : kSecClassGenericPassword,
			kSecAttrAccount as String : key,
			kSecReturnData as String  : kCFBooleanTrue,
			kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
		var dataTypeRef: AnyObject? = nil
		let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
		if status == noErr {
			return dataTypeRef as! Data?
		} else {
			return nil
		}
	}
	
	class func createUniqueID() -> String {
		let uuid: CFUUID = CFUUIDCreate(nil)
		let cfStr: CFString = CFUUIDCreateString(nil, uuid)
		
		let swiftString: String = cfStr as String
		return swiftString
	}
}


