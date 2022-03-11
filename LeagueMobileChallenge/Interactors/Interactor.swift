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
    
    func fetchAPIKey() -> AnyPublisher<APIKey, Error> {
        
        guard let url = URL(string: Constants.loginAPI) else {
            return AnyPublisher(Fail<APIKey, Error>(error: URLError(.badURL)))
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: APIKey.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.global(qos: .background))
            .eraseToAnyPublisher()
    }

     func fetchUsers() -> AnyPublisher<[User], Error> {
       
        guard let url = URL(string: Constants.userAPI) else {
            return AnyPublisher(Fail<[User], Error>(error: URLError(.badURL)))
        }
        
        var request = URLRequest(url: url)
         request.setValue(Defaults.apiKey?.fromBase64(), forHTTPHeaderField: "x-access-token")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map{$0.data}
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.global(qos: .background))
            .eraseToAnyPublisher()
    }

     func fetchPosts() -> AnyPublisher<[Post], Error> {

        guard let url = URL(string: Constants.postAPI) else {
            return AnyPublisher(Fail<[Post], Error>(error: URLError(.badURL)))
        }
        
        var request = URLRequest(url: url)
         request.setValue(Defaults.apiKey?.fromBase64(), forHTTPHeaderField: "x-access-token")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map{$0.data}
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.global(qos: .background))
            .eraseToAnyPublisher()
    }
    
    func fetchUsersPosts() -> AnyPublisher<([User], [Post]), Error> {
        Publishers.Zip(fetchUsers(), fetchPosts()).map { (users, posts) in
            return (users, posts)
        }.eraseToAnyPublisher()
    }
}
