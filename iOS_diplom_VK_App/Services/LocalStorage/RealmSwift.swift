//
//  RealmSwift.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 01.12.2022.
//

import Foundation
import RealmSwift

final class LocalStorage {
    
    static let shared = LocalStorage()
    
    // При изменении модели (моделей) нужно увеличить данный параметр
    let config = Realm.Configuration(schemaVersion: 1)
    var posts: [FeedViewModel.Post]
    var feedViewModel: FeedViewModel?
    var favouriteViewModel: FeedViewModel?
    var userInfoViewModel: UserInfoViewModel?
    var photosForHeader: [String]?
    var wallViewModel: WallViewModel?
    var wallPosts: [WallViewModel.Post]
    
    init() {
        Realm.Configuration.defaultConfiguration = config
        posts = []
        wallPosts = []
        // Вывести адрес базы данных
        print(Realm.Configuration.defaultConfiguration.fileURL?.path)
    }
}
