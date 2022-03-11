//
//  PostsViewModel.swift
//  LeagueMobileChallenge
//
//  Created by Nithin 3 on 11/03/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Foundation
import Combine

protocol PostsModel: AnyObject {
    func fetchLatestPosts()
}

class PostsViewModel {
    
    // MARK: Properties
    weak var postsModel: PostsModel?
    private let interactorDelegate: InteractorDelegate
    private let subscribers = Set<AnyCancellable>()
    
    init(interactorDelegate: InteractorDelegate) {
        self.interactorDelegate = interactorDelegate
    }
    
    func loadPosts() {
        
    }
}
