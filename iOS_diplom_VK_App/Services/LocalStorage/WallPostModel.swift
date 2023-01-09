//
//  WallPostModel.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 08.01.2023.
//

import Foundation
import RealmSwift

class WallPost: Object {
    @Persisted (primaryKey: true) var id: Int
    @Persisted var text: String
    @Persisted var date: Int
    @Persisted var totalHeight: Double
    @Persisted var name: String
    @Persisted var photo: String
    @Persisted var likesCount: Int
    @Persisted var userLikes: Int // 1 or 0
    @Persisted var commentsCount: Int
    @Persisted var repostsCount: Int
    @Persisted var viewsCount: Int
    @Persisted var photoAttachmentURL: String
    @Persisted var photoAttachmentWidth: Int
    @Persisted var photoAttachmentHeight: Int
    
    convenience init(id: Int,
                     text: String,
                     date:Int,
                     totalHeight: Double,
                     name: String,
                     photo: String,
                     likesCount: Int,
                     userLikes: Int,
                     commentsCount: Int,
                     repostsCount: Int,
                     viewsCount: Int,
                     photoAttachmentURL: String,
                     photoAttachmentWidth: Int,
                     photoAttachmentHeight: Int)
    {
        self.init()
        self.id = id
        self.text = text
        self.date = date
        self.totalHeight = totalHeight
        self.name = name
        self.photo = photo
        self.likesCount = likesCount
        self.userLikes = userLikes
        self.commentsCount = commentsCount
        self.repostsCount = repostsCount
        self.viewsCount = viewsCount
        self.photoAttachmentURL = photoAttachmentURL
        self.photoAttachmentWidth = photoAttachmentWidth
        self.photoAttachmentHeight = photoAttachmentHeight
    }
}
