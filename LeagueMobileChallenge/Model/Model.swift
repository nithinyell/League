//
//  Models.swift
//  LeagueMobileChallenge
//
//  Created by Nithin 3 on 11/03/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

// MARK: API KEY
struct APIKey: Codable {
    let apiKey: String
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
    }
}

// MARK: Users
struct Users: Codable {
    let users: [User]?
}

struct User: Codable {
    let id: Int?
    let name: String?
    let avatar: Avatar?
}

struct Avatar: Codable {
    let large: String?
}

// MARK: Posts
struct Posts: Codable {
    
}

struct Post: Codable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
}
