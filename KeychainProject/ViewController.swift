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
        KeychainService.shared.save(password, for: account)
        
        let retrievePassword = KeychainService.shared.retrieve(for: account)
        print(retrievePassword ?? "")
    }
}

