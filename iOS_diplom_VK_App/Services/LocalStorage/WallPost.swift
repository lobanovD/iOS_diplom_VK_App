//
//  WallPost.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 08.01.2023.
//

import Foundation

import RealmSwift

extension LocalStorage {
    
    // Метод добавления постов со стены в локальное хранилище
    func addWallPostsToLocalStorage(post: WallPost) {
        print("начинаем добавление постов со стены в хранилище")
        do {
            let realm = try Realm()
            guard realm.object(ofType: WallPost.self, forPrimaryKey: post.id) == nil else {
                let currentPost = realm.object(ofType: WallPost.self, forPrimaryKey: post.id)
                try realm.write {
                    currentPost?.text = post.text
                    currentPost?.totalHeight = post.totalHeight
                }
                return }
            
            try realm.write {
                realm.add(post)
            }
        } catch {}
    }
    
    // метод получения постов стены из хранилища
    func getWallModel() {
        wallViewModel = nil
        wallPosts = []
    
        do {
            let realm = try Realm()
            
//            let currentPostForView = realm.objects(FeedPost.self).sorted(byKeyPath: "date", ascending: false)
            let currentPostForView = realm.objects(WallPost.self)
        
            for post in currentPostForView {
                var currentPost = WallViewModel.Post()
//                let photoAttachment = FeedViewModel.FeedPostPhotoAttachment(photoUrlString: post.photoAttachmentURL, width: post.photoAttachmentWidth, height: post.photoAttachmentHeight)
                let photoAttachment = WallViewModel.WallPostPhotoAttachment(width: 100000, height: 100000)
                currentPost.id = post.id
                currentPost.text = post.text
                currentPost.date = post.date
                currentPost.totalHeight = post.totalHeight
                
//                currentPost.postID = post.postId
//                currentPost.sourceID = post.sourceId
//                currentPost.iconUrlString = post.iconUrlString
//                currentPost.name = post.name
//                currentPost.text = post.text
//                currentPost.userLikes = post.userLikes

//                currentPost.canLike = post.userCanLike
//                currentPost.likes = post.likesCount
//                currentPost.views = post.viewsCount
//                currentPost.shares = post.repostsCount
//                currentPost.comments = post.commentsCount
                
//                if photoAttachment.photoUrlString == "" {
//                    currentPost.photoAttachment = FeedViewModel.FeedPostPhotoAttachment(photoUrlString: "", width: 604, height: 340)
//                } else {
//
//                    currentPost.photoAttachment = photoAttachment
//                }
               
//                currentPost.totalHeight = post.totalHeight
                self.wallPosts.append(currentPost)
//                // ограничиваем вывод из базы только постами с фото
//                if photoAttachment.photoUrlString != "" {
//                    self.posts.append(currentPost)
//                }
            }
            wallViewModel = WallViewModel(posts: wallPosts)
        } catch {}
    }
    
    
    // Метод удаления всех постов со стены пользователя из локального хранилища
    func deleteAllWallPosts() {
        do {
            let realm = try Realm()
            let posts = realm.objects(WallPost.self)
        
            try realm.write {
                realm.delete(posts)
            }
        } catch {}
    }
    
    
    
}
