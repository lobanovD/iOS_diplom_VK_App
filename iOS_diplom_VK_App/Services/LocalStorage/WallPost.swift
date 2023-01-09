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
        do {
            let realm = try Realm()
            guard realm.object(ofType: WallPost.self, forPrimaryKey: post.id) == nil else {
                let currentPost = realm.object(ofType: WallPost.self, forPrimaryKey: post.id)
                try realm.write {
                    currentPost?.text = post.text
                    currentPost?.totalHeight = post.totalHeight
                    currentPost?.name = post.name
                    currentPost?.photo = post.photo
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
            let currentPostForView = realm.objects(WallPost.self)
            
            for post in currentPostForView {
                var currentPost = WallViewModel.Post()
                let photoAttachment = WallViewModel.WallPostPhotoAttachment(photoUrlString: post.photoAttachmentURL, width: post.photoAttachmentWidth, height: post.photoAttachmentHeight)
                currentPost.id = post.id
                currentPost.text = post.text
                currentPost.date = post.date
                currentPost.totalHeight = post.totalHeight
                currentPost.name = post.name
                currentPost.photo = post.photo
                currentPost.userLikes = post.userLikes
                currentPost.likes = post.likesCount
                currentPost.views = post.viewsCount
                currentPost.shares = post.repostsCount
                currentPost.comments = post.commentsCount
                
                if photoAttachment.photoUrlString == "" {
                    currentPost.photoAttachment = WallViewModel.WallPostPhotoAttachment(photoUrlString: "", width: 604, height: 340)
                } else {
                    
                    currentPost.photoAttachment = photoAttachment
                }
                
                self.wallPosts.append(currentPost)
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
