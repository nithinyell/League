//
//  Models.swift
//  LeagueMobileChallenge
//
//  Created by Nithin 3 on 11/03/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

// MARK: API KEY
struct APIKey: Codable {
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case key = "api_key"
    }
}

// MARK: Users
struct User: Codable {
    let id: Int?
    let name: String?
    let avatar: Avatar?
}

struct Avatar: Codable {
    let large: String?
}

// MARK: Posts
struct Post: Codable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
}

// MARK: UserPosts
struct UserPost: Codable {
    let user: User?
    let post: Post?
}
