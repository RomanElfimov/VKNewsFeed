//
//  UserResponse.swift
//  VKNewsFeed
//
//  Created by Роман Елфимов on 01.07.2021.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
