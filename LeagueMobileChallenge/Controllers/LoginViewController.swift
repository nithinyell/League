//
//  LoginViewController.swift
//  LeagueMobileChallenge
//
//  Created by Nithin 3 on 11/03/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginInButton: UIButton!
    let loginInteractor = LoginInteractor()

    override func viewDidLoad() {
        super.viewDidLoad()

        loginInteractor.interactorDelegate = Interactor()
        loginInteractor.loginStatus = self
        
        // MARK: Is User Loged-in
        if let _ = Defaults.apiKey {
            navigateToPostsViewController()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
        designLoginButton()
    }
    
    @IBAction func onPressLogin(_ sender: Any) {
        loginInteractor.fecthApiKey()
    }
    
    private func navigateToPostsViewController() {
        
        DispatchQueue.main.async { [weak self] in
            
            if let postsViewController = self?.storyboard?.instantiateViewController(withIdentifier: "PostsViewController") as? PostsViewController {
                    self?.navigationController?.pushViewController(postsViewController, animated: true)
            }
        }
    }
    
    private func designLoginButton() {
        loginInButton.backgroundColor = .clear
        loginInButton.layer.cornerRadius = 10
        loginInButton.layer.borderWidth = 2.5
        loginInButton.layer.borderColor = UIColor.black.cgColor
    }
}

extension LoginViewController: LoginStatus {
    
    func loginStatus(success: Bool) {
        navigateToPostsViewController()
    }
}
