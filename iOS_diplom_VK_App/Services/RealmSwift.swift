//
//  RealmSwift.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 01.12.2022.
//

import Foundation
import RealmSwift


class FeedPost: Object {
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
    @Persisted var iconUrlString: String
    @Persisted var totalHeight: String
    @Persisted var name: String
  
    
    
    convenience init(sourceId: Int,
                     postId: Int,
                     text: String,
                     date: Int,
                     commentsCount: Int,
                     likesCount: Int,
                     userLikes: Int,
                     userCanLike: Int,
                     repostsCount: Int,
                     viewsCount: Int,
                     iconUrlString: String
    ) {
        
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
        self.iconUrlString = iconUrlString
        
    }
}
    

    

    
    final class LocalStorage {
        
        static let shared = LocalStorage()
        
        
        // При изменении модели (моделей) нужно увеличить данный параметр
        let config = Realm.Configuration(schemaVersion: 1)
            var posts: [FeedViewModel.Post]
            var feedViewModel: FeedViewModel?
        
        init() {
            Realm.Configuration.defaultConfiguration = config
            // Вывести адрес базы данных
//            print(Realm.Configuration.defaultConfiguration.fileURL?.path)
            
            posts = []
//            feedViewModel = FeedViewModel(posts: posts)
        }
        
        
        // Метод добавления постов в локальное хранилище
        func addPostsToLocalStorage(post: FeedPost) {
            checkPostInRealmAndAdd(post: post)
        }
        
        // Метод проверки существует ли пост в локальном хранилище
        private func checkPostInRealmAndAdd(post: FeedPost) {
            do {
                
                
                let realm = try Realm()
                guard realm.object(ofType: FeedPost.self, forPrimaryKey: post.postId) == nil else {
                    let currentPost = realm.object(ofType: FeedPost.self, forPrimaryKey: post.postId)
                    try realm.write{
                        currentPost?.text = post.text
                        currentPost?.viewsCount = post.viewsCount
                        currentPost?.repostsCount = post.repostsCount
                        currentPost?.userCanLike = post.userCanLike
                        currentPost?.userLikes = post.userLikes
                        currentPost?.likesCount = post.likesCount
                        currentPost?.commentsCount = post.commentsCount
                        currentPost?.iconUrlString = post.iconUrlString
                    }
                    
                    return }
                
                try realm.write {
                    realm.add(post)
                }
                
                
            } catch {
                //            print(error.localizedDescription)
            }
        }
        
        
        
        // Метод записи поста в Local Storage
        private func writeToRealm(post: FeedPost) {
            do {
                let realm = try Realm()
                
                try realm.write {
                    realm.add(post)
                }
            } catch {
                //            print(error.localizedDescription)
            }
        }
        
        
        
        // метод получения постов из хранилища
        func getFeedModel() {
            
            let realm = try! Realm()
            
            let allPosts = realm.objects(FeedPost.self)
            
            for post in allPosts {
                
                var currentPost = FeedViewModel.Post()
                
                currentPost.postID = post.postId
                currentPost.sourceID = post.sourceId
                currentPost.text = post.text
                currentPost.userLikes = post.userLikes
                currentPost.date = post.date
                currentPost.canLike = post.userCanLike
                currentPost.likes = post.likesCount
                currentPost.views = post.viewsCount
                currentPost.shares = post.repostsCount
                currentPost.comments = post.commentsCount
                currentPost.iconUrlString = post.iconUrlString
                currentPost.name = ""
                currentPost.photoAttachment = nil
                currentPost.totalHeight = 100
                
               
                self.posts.append(currentPost)
                
                
            }
            
            feedViewModel = FeedViewModel(posts: posts)
//            print(feedViewModel)
            
     
   
        }
        
        
        
        
        
        
        
    }
    

