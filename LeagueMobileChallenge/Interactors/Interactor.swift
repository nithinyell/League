//
//  Interactor.swift
//  LeagueMobileChallenge
//
//  Created by Nithin 3 on 11/03/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Foundation
import Combine

protocol InteractorDelegate {
    func fetchAPIKey() -> AnyPublisher<APIKey, Error>
    func fetchUsers() -> AnyPublisher<[User], Error>
    func fetchPosts() -> AnyPublisher<[Post], Error>
    func fetchUsersPosts() -> AnyPublisher<([User], [Post]), Error>
}

class Interactor: InteractorDelegate {
    
    /// Generic Build Request to map and decode data
    /// - Returns: Generic T
    func buildRequest<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        let dataTaskPublisher = URLSession.shared.dataTaskPublisher(for: request)
            .map{ $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        return dataTaskPublisher
    }
    
    ///  Publisher to fetch API Key
    /// - Returns: Api Key of Type String
    func fetchAPIKey() -> AnyPublisher<APIKey, Error> {
        
        guard let url = URL(string: Constants.loginAPI) else {
            return AnyPublisher(Fail<APIKey, Error>(error: URLError(.badURL)))
        }
        
        let request = URLRequest(url: url)
        return buildRequest(request).receive(on: DispatchQueue.global(qos: .background))
            .eraseToAnyPublisher()
    }
    
    /// Publisher to fetch Users
    /// - Returns: [User]
     func fetchUsers() -> AnyPublisher<[User], Error> {
       
        guard let url = URL(string: Constants.userAPI) else {
            return AnyPublisher(Fail<[User], Error>(error: URLError(.badURL)))
        }
        
        var request = URLRequest(url: url)
         request.setValue(Defaults.apiKey?.fromBase64(), forHTTPHeaderField: "x-access-token")
        
         return buildRequest(request).receive(on: DispatchQueue.global(qos: .background))
             .eraseToAnyPublisher()
     }
    
    /// Publisher to fetch Posts
    /// - Returns: [Post]
     func fetchPosts() -> AnyPublisher<[Post], Error> {

        guard let url = URL(string: Constants.postAPI) else {
            return AnyPublisher(Fail<[Post], Error>(error: URLError(.badURL)))
        }
        
        var request = URLRequest(url: url)
         request.setValue(Defaults.apiKey?.fromBase64(), forHTTPHeaderField: "x-access-token")
        
         return buildRequest(request).receive(on: DispatchQueue.global(qos: .background))
             .eraseToAnyPublisher()
    }
    
    /// Publisher to fetch User Posts
    /// - Returns: ([User], [Post])
    func fetchUsersPosts() -> AnyPublisher<([User], [Post]), Error> {
        Publishers.Zip(fetchUsers(), fetchPosts()).map { (users, posts) in
            return (users, posts)
        }.eraseToAnyPublisher()
    }
}
