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
    @Persisted var totalHeight: Double
    @Persisted var name: String
    @Persisted var photoAttachmentURL: String
    @Persisted var photoAttachmentWidth: Int
    @Persisted var photoAttachmentHeight: Int
    
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
                     iconUrlString: String,
                     name: String,
                     totalHeight: Double,
                     photoAttachmentURL: String,
                     photoAttachmentWidth: Int,
                     photoAttachmentHeight: Int)
    {
        
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
        self.name = name
        self.totalHeight = totalHeight
        self.photoAttachmentURL = photoAttachmentURL
        self.photoAttachmentWidth = photoAttachmentWidth
        self.photoAttachmentHeight = photoAttachmentHeight
    }
}

final class LocalStorage {
    
    static let shared = LocalStorage()
    
    // При изменении модели (моделей) нужно увеличить данный параметр
    let config = Realm.Configuration(schemaVersion: 1)
    var posts: [FeedViewModel.Post]
    var feedViewModel: FeedViewModel?
    var favouriteViewModel: FeedViewModel?
    
    init() {
        Realm.Configuration.defaultConfiguration = config
        posts = []
        // Вывести адрес базы данных
//                    print(Realm.Configuration.defaultConfiguration.fileURL?.path)
    }
    
    
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
    
    // Метод записи поста в Local Storage
    private func writeToRealm(post: FeedPost) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(post)
            }
        } catch {}
    }
    
    // метод получения постов из хранилища
    func getFeedModel() {
        
        feedViewModel = nil
        posts = []
        do {
            let realm = try Realm()
            let allPosts = realm.objects(FeedPost.self).sorted(byKeyPath: "date", ascending: false)
            for post in allPosts {
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
            
            print(11111, self.favouriteViewModel?.posts.count)
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

