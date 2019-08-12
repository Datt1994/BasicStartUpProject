//
//  LoginVC.swift
//  BasicStartUpProject
//
//  Created by datt on 12/08/19.
//  Copyright © 2019 Datt. All rights reserved.
//

import UIKit

class LoginVC: UIViewController , Storyboarded {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Title.home
        
        // Do any additional setup after loading the view.
    }
    //MARK: - Api call
    func wsLogin() {
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.view.makeToast(AlertMessage.networkConnection)
            return
        }
        
        var paramDic = Dictionary<String, Any>()
        paramDic[WebServiceParameter.emailID] = "abc@gmail.com"
        paramDic[WebServiceParameter.password] = "password"
        paramDic[WebServiceParameter.deviceToken] = 1
        
        ApiCall().post(apiUrl: WebServiceURL.logInURL, requestPARAMS: paramDic ,model: LoginModel.self, isErrorToast : true) {
            [weak self](success, response) in
            if success ,  let response = response as? LoginModel {
                // Save model class object
                UserDefaults.standard.save(customObject: response.data, inKey: UserDefaultKey.loginData)
                Global.shared.isLogIn = true
                self?.navigationController?.popViewController()
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
