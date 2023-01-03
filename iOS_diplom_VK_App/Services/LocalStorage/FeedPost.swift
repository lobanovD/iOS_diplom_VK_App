//
//  FeedPost.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 28.12.2022.
//

import Foundation
import RealmSwift

extension LocalStorage {
    
    // Метод добавления постов в локальное хранилище
    func addPostsToLocalStorage(post: FeedPost) {
        do {
            let realm = try Realm()
            guard realm.object(ofType: FeedPost.self, forPrimaryKey: post.postId) == nil else {
                let currentPost = realm.object(ofType: FeedPost.self, forPrimaryKey: post.postId)
                try realm.write {
                    currentPost?.text = post.text
                    currentPost?.viewsCount = post.viewsCount
                    currentPost?.repostsCount = post.repostsCount
                    currentPost?.userCanLike = post.userCanLike
                    currentPost?.userLikes = post.userLikes
                    currentPost?.likesCount = post.likesCount
                    currentPost?.commentsCount = post.commentsCount
                    currentPost?.iconUrlString = post.iconUrlString
                    currentPost?.name = post.name
                    currentPost?.photoAttachmentURL = post.photoAttachmentURL
                    currentPost?.photoAttachmentHeight = post.photoAttachmentHeight
                    currentPost?.photoAttachmentWidth = post.photoAttachmentWidth
                }
                return }
            
            try realm.write {
                realm.add(post)
            }
        } catch {}
    }
    
//    // Метод записи поста в Local Storage
//    private func writeToRealm(post: FeedPost) {
//        do {
//            let realm = try Realm()
//            try realm.write {
//                realm.add(post)
//            }
//        } catch {}
//    }
    
    // метод получения постов из хранилища
    func getFeedModel() {
        feedViewModel = nil
        posts = []
    
        do {
            let realm = try Realm()
            
            let currentPostForView = realm.objects(FeedPost.self).sorted(byKeyPath: "date", ascending: false)
        
            for post in currentPostForView {
                var currentPost = FeedViewModel.Post()
                let photoAttachment = FeedViewModel.FeedPostPhotoAttachment(photoUrlString: post.photoAttachmentURL, width: post.photoAttachmentWidth, height: post.photoAttachmentHeight)
                
                currentPost.postID = post.postId
                currentPost.sourceID = post.sourceId
                currentPost.iconUrlString = post.iconUrlString
                currentPost.name = post.name
                currentPost.text = post.text
                currentPost.userLikes = post.userLikes
                currentPost.date = post.date
                currentPost.canLike = post.userCanLike
                currentPost.likes = post.likesCount
                currentPost.views = post.viewsCount
                currentPost.shares = post.repostsCount
                currentPost.comments = post.commentsCount
                
                if photoAttachment.photoUrlString == "" {
                    currentPost.photoAttachment = FeedViewModel.FeedPostPhotoAttachment(photoUrlString: "", width: 604, height: 340)
                } else {
                    
                    currentPost.photoAttachment = photoAttachment
                }
               
                currentPost.totalHeight = post.totalHeight
                self.posts.append(currentPost)
//                // ограничиваем вывод из базы только постами с фото
//                if photoAttachment.photoUrlString != "" {
//                    self.posts.append(currentPost)
//                }
            }
            feedViewModel = FeedViewModel(posts: posts)
        } catch {}
    }
    
    // Метод получения Избранных постов
    func getFavouritePost() {
        favouriteViewModel = nil
        posts = []
        do {
            let realm = try Realm()
            let allPosts = realm.objects(FeedPost.self).sorted(byKeyPath: "date", ascending: false)
            let allFavouritePosts = allPosts.where {
                $0.userLikes == 1
            }
            
            for post in allFavouritePosts {
                var currentPost = FeedViewModel.Post()
                let photoAttachment = FeedViewModel.FeedPostPhotoAttachment(photoUrlString: post.photoAttachmentURL, width: post.photoAttachmentWidth, height: post.photoAttachmentHeight)
                
                currentPost.postID = post.postId
                currentPost.sourceID = post.sourceId
                currentPost.iconUrlString = post.iconUrlString
                currentPost.name = post.name
                currentPost.text = post.text
                currentPost.userLikes = post.userLikes
                currentPost.date = post.date
                currentPost.canLike = post.userCanLike
                currentPost.likes = post.likesCount
                currentPost.views = post.viewsCount
                currentPost.shares = post.repostsCount
                currentPost.comments = post.commentsCount
                
                if photoAttachment.photoUrlString == "" {
                    currentPost.photoAttachment = FeedViewModel.FeedPostPhotoAttachment(photoUrlString: "", width: 604, height: 340)
                } else {
                    
                    currentPost.photoAttachment = photoAttachment
                }
               
                currentPost.totalHeight = post.totalHeight
                self.posts.append(currentPost)
            }
            favouriteViewModel = FeedViewModel(posts: posts)
            
        } catch {}
    }
    
    // Метод обновления статуса "лайка"
    func likeStatusUpdate(index: Int, typePage: TypePage) {
        do {
            let realm = try Realm()
            let posts: Results<FeedPost>?
            
            switch typePage {
            case .FeedNews:
                posts = realm.objects(FeedPost.self).sorted(byKeyPath: "date", ascending: false)
            case .Favourite:
                let allPosts = realm.objects(FeedPost.self).sorted(byKeyPath: "date", ascending: false)
                posts = allPosts.where {
                    $0.userLikes == 1
                }
            }
            guard let posts = posts else { return }
            let currentPost = posts[index]
            let status = currentPost.userLikes
            if status == 0 {
                try realm.write {
                    currentPost.userLikes = 1
                    currentPost.likesCount += 1
                }
                NetworkService.shared.addLike(sourceID: currentPost.sourceId, postID: currentPost.postId)
            } else {
                try realm.write {
                    currentPost.userLikes = 0
                    currentPost.likesCount -= 1
                }
                NetworkService.shared.removeLike(sourceID: currentPost.sourceId, postID: currentPost.postId)
            }
            LocalStorage.shared.getFeedModel()
        } catch {}
    }
}
