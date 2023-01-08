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
    
//    @Persisted var sourceId: Int
//    @Persisted var text: String
//    @Persisted var date: Int
//    @Persisted var commentsCount: Int
//    @Persisted var likesCount: Int
//    @Persisted var userLikes: Int // 1 or 0
//    @Persisted var userCanLike: Int // 1 or 0
//    @Persisted var repostsCount: Int
//    @Persisted var viewsCount: Int
//    @Persisted var iconUrlString: String

//    @Persisted var name: String
//    @Persisted var photoAttachmentURL: String
//    @Persisted var photoAttachmentWidth: Int
//    @Persisted var photoAttachmentHeight: Int
    
    
    convenience init(id: Int,
                     text: String,
                     date:Int,
                     totalHeight: Double)
    {
        
        self.init()
        self.id = id
        self.text = text
        self.date = date
        self.totalHeight = totalHeight

    }
}
