//
//  PostsViewModel.swift
//  LeagueMobileChallenge
//
//  Created by Nithin 3 on 11/03/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Foundation
import Combine

protocol PostsModelDelegate: AnyObject {
    func fetchLatestPosts(userPosts: [UserPost]?)
    func fetchLatestPostsFailed()
}

class PostsViewModel {
    
    // MARK: Properties
    weak var postsModel: PostsModelDelegate?
    private let interactorDelegate: InteractorDelegate
    var subscribers = Set<AnyCancellable>()
    
    init(interactorDelegate: InteractorDelegate) {
        self.interactorDelegate = interactorDelegate
    }
    
    func loadPosts() {
        interactorDelegate.fetchUsersPosts().sink { completion in
            switch completion {
            case .finished:
                break
            case .failure( _):
                self.postsModel?.fetchLatestPostsFailed()
            }
        } receiveValue: { [weak self] (users, posts) in
            let posts = self?.transformPosts(users: users, posts: posts)
            self?.postsModel?.fetchLatestPosts(userPosts: posts)
        }.store(in: &subscribers)
    }
    
    func transformPosts(users: [User], posts: [Post]) -> [UserPost]? {
    
        var userPosts = [UserPost]()
        posts.forEach { post in
            userPosts.append(UserPost(user: users.filter{$0.id == post.userId}.first, post: post))
        }
        
        return userPosts
    }
}
