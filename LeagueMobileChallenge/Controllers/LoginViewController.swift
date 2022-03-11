//
//  LoginViewController.swift
//  LeagueMobileChallenge
//
//  Created by Nithin 3 on 11/03/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var onPressLogin: UIButton!
    let loginInteractor = LoginInteractor()

    override func viewDidLoad() {
        super.viewDidLoad()

        loginInteractor.interactorDelegate = Interactor()
        loginInteractor.loginStatus = self
    }
    
    @IBAction func onPressLogin(_ sender: Any) {
        
        loginInteractor.fecthApiKey()
    }
}

extension LoginViewController: LoginStatus {
    func loginStatus(success: Bool) {
        print("LOGIN IS: ", success)
    }
}
