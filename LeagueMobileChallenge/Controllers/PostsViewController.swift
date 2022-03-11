//
//  PostsViewController.swift
//  LeagueMobileChallenge
//
//  Created by Nithin 3 on 11/03/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {
 
    // MARK: Properties
    @IBOutlet weak var postsTableView: UITableView!
    private let postsViewModel = PostsViewModel(interactorDelegate: Interactor())
    let refreshControl = UIRefreshControl()

    private var userPosts: [UserPost]? {
        didSet {
            reloadTableViewData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        postsViewModel.postsModel = self
        loadData()
        navigationBarSetUp()
        logoutbuttonSetUp()
        tableViewSetUp()
    }
    
    private func navigationBarSetUp() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.title = "Posts"
    }
    
    private func logoutbuttonSetUp() {
        let logoutBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutUser))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
    }
    
    @objc func logoutUser(){
        UserDefaults.standard.removeObject(forKey: Constants.APIKEY)
        imageCache.removeAllObjects()
        navigationController?.popViewController(animated: false)
    }
    
    private func tableViewSetUp() {
        postsTableView.rowHeight = UITableView.automaticDimension
        postsTableView.estimatedRowHeight = 80
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.loadData), for: .valueChanged)
        postsTableView.addSubview(refreshControl)
    }
    
    @objc private func loadData() {
        postsViewModel.loadPosts()
    }
    
    private func reloadTableViewData() {
        DispatchQueue.main.async { [weak self] in
            self?.postsTableView.reloadData()
        }
    }
}

// MARK: TableViewDelegate
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

// MARK: TableViewDataSource
extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPosts?.count ?? 0
    }
}

// MARK: PostsViewController Custom Extensions
extension PostsViewController: PostsModelDelegate {
    func fetchLatestPosts(userPosts: [UserPost]?) {
        DispatchQueue.main.async { [weak self] in
            self?.userPosts = userPosts
            self?.refreshControl.endRefreshing()
        }
    }
    
    func fetchLatestPostsFailed() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()

            let alert = UIAlertController(title: "Retry", message: "Failed to Load Posts", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (action: UIAlertAction!) in
                self?.loadData()
            }))
            
            self?.present(alert, animated: true, completion: nil)
        }
    }
}
