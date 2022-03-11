//
//  PostTableViewCell.swift
//  LeagueMobileChallenge
//
//  Created by Nithin 3 on 11/03/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    var userPostData: UserPost? {
        didSet {
            dataBind()
        }
    }
    
    lazy var userAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var userPost: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        configureUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
 
    private func configureUI() {
        self.addSubview(userAvatar)
        self.addSubview(userName)
        self.addSubview(userPost)
        
        NSLayoutConstraint.activate([
            userAvatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            userAvatar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            userAvatar.widthAnchor.constraint(equalToConstant: 50),
            userAvatar.heightAnchor.constraint(equalToConstant: 50),
            userAvatar.bottomAnchor.constraint(equalTo: userPost.topAnchor, constant: -20),

            userName.topAnchor.constraint(equalTo: userAvatar.topAnchor),
            userName.heightAnchor.constraint(equalTo: userAvatar.heightAnchor),
            userName.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: 10),
            
            userPost.leadingAnchor.constraint(equalTo: userAvatar.leadingAnchor),
            userPost.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            userPost.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    private func dataBind() {
        guard let post = self.userPostData else { return }
        
        userName.text = post.user?.name
        userPost.text = post.post?.title
    }
}
