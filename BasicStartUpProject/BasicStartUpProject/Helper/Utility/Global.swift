//
//  Global.swift
//
//  Created by Datt on 07/09/18.
//  Copyright © 2018 Datt. All rights reserved.
//

import Foundation

class Global {
 
    static let shared = Global()
    var isLogIn = false
    var xyz: [String:String]?

    
    func logOut() {
        Global.shared.isLogIn = false
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.loginData)
    }
}

