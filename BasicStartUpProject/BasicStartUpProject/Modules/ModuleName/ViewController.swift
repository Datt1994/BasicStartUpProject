//
//  ViewController.swift
//  BasicStartUpProject
//
//  Created by datt on 12/08/19.
//  Copyright © 2019 Datt. All rights reserved.
//

import UIKit

class ViewController: UIViewController , Storyboarded {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Title.home
        if let objLoginData = UserDefaults.standard.retrieve(object: LoginData.self, fromKey: UserDefaultKey.loginData) {
            print(objLoginData)
            Global.shared.isLogIn = true
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnAction(_ sender: UIButton) {
        let objLoginVC = LoginVC.instantiate()
        self.navigationController?.pushViewController(objLoginVC)
    }
    
}

