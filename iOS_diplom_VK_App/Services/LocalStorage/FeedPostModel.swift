//
//  FeedPostModel.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 28.12.2022.
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
