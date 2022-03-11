//
//  PostsViewController.swift
//  LeagueMobileChallenge
//
//  Created by Nithin 3 on 11/03/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {
 
    @IBOutlet weak var postsTableView: UITableView!
    private let postsViewModel = PostsViewModel(interactorDelegate: Interactor())
    private var userPosts: [UserPost]? {
        didSet {
            reloadTableViewData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        postsViewModel.postsModel = self
        postsViewModel.loadPosts()
        navigationBarSetUp()
        logoutbuttonSetUp()
        tableViewSetUp()
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
    
    private func tableViewSetUp() {
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.estimatedRowHeight = 80
    }
    
    private func reloadTableViewData() {
        DispatchQueue.main.async { [weak self] in
            self?.postsTableView.reloadData()
        }
    }
}

extension PostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PostTableViewCell {
            
            cell.userPostData = userPosts?[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPosts?.count ?? 0
    }
}

extension PostsViewController: PostsModelDelegate {
    func fetchLatestPosts(userPosts: [UserPost]?) {
        self.userPosts = userPosts
        print("posts", userPosts)
    }
}


