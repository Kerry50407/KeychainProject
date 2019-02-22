//
//  ViewController.swift
//  KeychainProject
//
//  Created by KerryDong on 2018/12/3.
//  Copyright © 2018 KerryDong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let account = "kerry"
        let password = "111122223333"
        let keychainService = KeychainService()
        keychainService.save(password, for: account)
        
        let retrievePassword = keychainService.retrieve(for: account)
        print(retrievePassword ?? "")
        
    }


}

