//
//  API.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 09.08.2022.
//

import Foundation

// MARK: Основное
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

// MARK: Лента
// Получение ленты пользователя
struct GetFeed {
    static let path = "/method/newsfeed.get"
    static let filtersName = "filters"
    static let filtersValue = "post,photo"
    static let countName = "count"
    static let countValue = "100"
}

// Обработка лайков
struct LikeActions {
    static let addLikePath = "/method/likes.add"
    static let removeLikePath = "/method/likes.delete"
    static let ownerID = "owner_id"
    static let itemID = "item_id"
    static let type = "type"
    static let post = "post"
}

// MARK: Пользователь
// Получение данных о пользователе
struct GetUserInfo {
    static let path = "/method/users.get"
}

// MARK: Фотографии
struct GetPhoto {
    static let photoPath = "/method/photos.getAll"
}

// MARK: Стена
struct GetWall {
    static let path = "/method/wall.get"
    static let extended = "extended"
    static let extendedStatus = "1"
}
