//
//  KeychainService.swift
//  KeychainProject
//
//  Created by KerryDong on 2018/12/3.
//  Copyright © 2018 KerryDong. All rights reserved.
//

import Foundation

class KeychainService {
    static let shared = KeychainService()
    
    private init() {}
    
    func save(_ value: String, for key: String) {
        let valueData = value.data(using: .utf8) ?? Data()
        let query: [String : Any] = [kSecClass as String: kSecClassGenericPassword,
                                     kSecAttrAccount as String: key,
                                     kSecValueData as String: valueData]
        var item: CFTypeRef?
        let queryStatus = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard queryStatus == errSecSuccess else {
            let addStatus = SecItemAdd(query as CFDictionary, nil)
            
            if addStatus != errSecSuccess {
                print("Failed to save keychain")
            }
            return
        }
        
        let updateStatus = SecItemUpdate(query as CFDictionary, [kSecValueData as String: valueData] as CFDictionary)
        
        if updateStatus != errSecSuccess {
            print("Failed to update keychain")
        }
    }
    
    func retrieve(for key: String) -> String? {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: key,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecReturnData as String: kCFBooleanTrue]
        
        var retrieveData: AnyObject? = nil
        SecItemCopyMatching(query as CFDictionary, &retrieveData)
        
        guard let data = retrieveData as? Data else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
}
