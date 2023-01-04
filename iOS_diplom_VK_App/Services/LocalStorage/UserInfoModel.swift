//
//  UserInfoModel.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 28.12.2022.
//

import Foundation
import RealmSwift

class UserInfo: Object {
    @Persisted (primaryKey: true) var id: Int
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var about: String
    @Persisted var status: String
    @Persisted var photo200: String
    
    convenience init(id: Int,
                     firstName: String,
                     lastName: String,
                     about: String,
                     status: String,
                     photo200: String)
    {
        self.init()
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.about = about
        self.status = status
        self.photo200 = photo200
    }
}

class UserPhotos: Object {
    @Persisted (primaryKey: true) var id: Int
    @Persisted var url: String
    
    convenience init(id: Int,
                     url: String) {
        self.init()
        self.id = id
        self.url = url
    }
    
}
