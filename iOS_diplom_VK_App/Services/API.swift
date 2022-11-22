//
//  API.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 09.08.2022.
//

import Foundation

struct API {
    // Запрашиваемые разрешения (https://dev.vk.com/reference/access-rights)
    static let scope = ["offline", "wall", "friends", "photos"]
    // ID приложения
    static let appID = "51425771"
    // Протокол запросов к API
    static let scheme = "https"
    // Адрес API
    static let host = "api.vk.com"
    // Версия API (https://dev.vk.com/reference/versions)
    static let version = "5.131"
    
}

enum APIParams: String {
    case apiToken = "access_token"
    case apiVersion = "v"
}

// MARK: Структуры методов API

// Получение ленты пользователя
struct GetFeed {
    static let path = "/method/newsfeed.get"
    static let name = "filters"
    static let value = "post,photo,video"
}

struct GetUserInfo {
    static let path = "/method/account.getProfileInfo"
}

struct AddLike {
    static let path = "/method/likes.add"
    static let ownerID = "owner_id"
    static let itemID = "item_id"
    static let type = "type"
    static let post = "post"
}
