//
//  PostsViewController.swift
//  LeagueMobileChallenge
//
//  Created by Nithin 3 on 11/03/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationBarSetUp()
        logoutbuttonSetUp()
    }
    
    private func navigationBarSetUp() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.title = "Posts"
    }
    
    private func logoutbuttonSetUp() {
        let logoutBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutUser))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
    }
    
    @objc func logoutUser(){
        UserDefaults.standard.removeObject(forKey: Constants.APIKEY)
        navigationController?.popViewController(animated: false)
    }
}

extension PostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell {
            
            cell.textLabel?.text = "Jai guru"
            
            return cell
        }
        
        return UITableViewCell()
    }
}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}
