//
//  KeychainService.swift
//  KeychainProject
//
//  Created by KerryDong on 2018/12/3.
//  Copyright © 2018 KerryDong. All rights reserved.
//

import Foundation
import CryptoSwift

class KeychainService {
    func save(_ password: String, for account: String) {
        let password = password.data(using: String.Encoding.utf8) ?? Data()
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: account,
                                    kSecValueData as String: password]
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status != errSecSuccess {
            print("Failed to save keychain")
        }
    }
    
    func saveEncryptedPassword(_ password: String, for account: String) {
        let salt = Array("Salty".utf8)
        let key = try! HKDF(password: Array(password.utf8), salt: salt, variant: .sha256).calculate().toHexString()
        save(key, for: account)
    }
    
    func retrieve(for account: String) -> String? {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: account,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecReturnData as String: kCFBooleanTrue]
        
        var retrieveData: AnyObject? = nil
        SecItemCopyMatching(query as CFDictionary, &retrieveData)
        
        guard let data = retrieveData as? Data else {
            print("Failed to retrieve keychain")
            return nil
        }
        
        return String(data: data, encoding: String.Encoding.utf8)
    }
}
