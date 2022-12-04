//
//  RealmSwift.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 01.12.2022.
//

import Foundation
import RealmSwift


class Post: Object {
    @Persisted (primaryKey: true) var postId: Int
    @Persisted var sourceId: Int
    @Persisted var text: String
    @Persisted var date: Int
    @Persisted var commentsCount: Int
    @Persisted var likesCount: Int
    @Persisted var userLikes: Int // 1 or 0
    @Persisted var userCanLike: Int // 1 or 0
    @Persisted var repostsCount: Int
    @Persisted var viewsCount: Int
    

    

    convenience init(sourceId: Int,
                     postId: Int,
                     text: String,
                     date: Int,
                     commentsCount: Int,
                     likesCount: Int,
                     userLikes: Int,
                     userCanLike: Int,
                     repostsCount: Int,
                     viewsCount: Int) {
        
        self.init()
        self.postId = postId
        self.sourceId = sourceId
        self.text = text
        self.date = date
        self.commentsCount = commentsCount
        self.likesCount = likesCount
        self.userLikes = userLikes
        self.userCanLike = userCanLike
        self.repostsCount = repostsCount
        self.viewsCount = viewsCount
        
    }
}



class LocalStorage {
    
    static let shared = LocalStorage()
    
    // При изменении модели (моделей) нужно увеличить данный параметр
    let config = Realm.Configuration(schemaVersion: 1)
    
    
    
    
    func addPostsToLocalStorage(post: Post) {
        Realm.Configuration.defaultConfiguration = config
        
        // Вывести адрес базы данных
//                print(Realm.Configuration.defaultConfiguration.fileURL?.path)
        
        checkPostInRealm(post: post)
        
        
    }
    
    
    private func checkPostInRealm(post: Post) {
        
        do {
            let realm = try Realm()
            
            let specificPerson = realm.object(ofType: Post.self, forPrimaryKey: post.postId)
            
           
            
            if specificPerson == nil {
                try realm.write {
                    realm.add(post)
                }
            } else {
                return
            }
            
//            if currentPost.isEmpty {
//                writeToRealm(post: post)
//            } else {
//                return
//            }
            
        } catch {
            
        }
        
    }
    
    // Метод записи поста в Local Storage
    private func writeToRealm(post: Post) {
        do {
            
            let realm = try Realm()
            
            try realm.write {
                realm.add(post)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}

