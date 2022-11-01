//
//  API.swift
//  VKNewsFeed
//
//  Created by Роман Елфимов on 27.06.2021.
//

import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.vk.com"
    static let version = "5.131"
    
    // Метод для получения новостей
    static let newsFeed = "/method/newsfeed.get"
    
    // Метод для получения данных о пользоателе
    static let user = "/method/users.get"
}
