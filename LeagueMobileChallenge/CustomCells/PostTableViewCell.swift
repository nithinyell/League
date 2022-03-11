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
    
    lazy var userPostTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var userPostBody: UILabel = {
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
        self.addSubview(userPostTitle)
        self.addSubview(userPostBody)
        
        NSLayoutConstraint.activate([
            userAvatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            userAvatar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            userAvatar.widthAnchor.constraint(equalToConstant: 100),
            userAvatar.heightAnchor.constraint(equalToConstant: 100),

            userName.topAnchor.constraint(equalTo: userAvatar.topAnchor),
            userName.heightAnchor.constraint(equalTo: userAvatar.heightAnchor),
            userName.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: 10),
            
            userPostTitle.topAnchor.constraint(equalTo: userAvatar.bottomAnchor, constant: 20),
            userPostTitle.leadingAnchor.constraint(equalTo: userAvatar.leadingAnchor),
            userPostTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            userPostTitle.bottomAnchor.constraint(equalTo: userPostBody.topAnchor, constant: -10),
            
            userPostBody.topAnchor.constraint(equalTo: userPostTitle.bottomAnchor, constant: 10),
            userPostBody.leadingAnchor.constraint(equalTo: userPostTitle.leadingAnchor),
            userPostBody.trailingAnchor.constraint(equalTo: userPostTitle.trailingAnchor),
            userPostBody.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    private func dataBind() {
        guard let post = self.userPostData else { return }
        
        let imageUrl = post.user?.avatar?.large?.asURL()
        imageUrl?.fetchImageFromURL(onSuccess: { (image) in
            
            if let image = image {
                DispatchQueue.main.async { [weak self] in
                    self?.userAvatar.makeRoundImageView(image: image)
                }
            }
        })
        
        self.userName.text = post.user?.name
        self.userPostTitle.text = post.post?.title
        self.userPostBody.text = post.post?.body
    }
}
