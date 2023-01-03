//
//  UserInfo.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 28.12.2022.
//

import Foundation
import RealmSwift

extension LocalStorage {
    // Метод добавления информации о пользователе в локальное хранилище
    func addUserInfo(user: UserInfo) {
        do {
            let realm = try Realm()
            guard realm.object(ofType: UserInfo.self, forPrimaryKey: user.id) == nil else {
                let currentUser = realm.object(ofType: UserInfo.self, forPrimaryKey: user.id)
                try realm.write {
                    currentUser?.firstName = user.firstName
                    currentUser?.lastName = user.lastName
                    currentUser?.about = user.about
                    currentUser?.status = user.status
                }
                return }
            
            try realm.write {
                realm.add(user)
            }
        } catch {}
    }
    // метод получения данных о пользователе из локального хранилища
    func getUserModel() {
        userInfoViewModel = nil
    
        do {
            let realm = try Realm()
            let user = realm.objects(UserInfo.self)
            var currentUser = UserInfoViewModel()
            currentUser.firstName = user[0].firstName
            currentUser.lastName = user[0].lastName
            currentUser.status = user[0].status
            currentUser.about = user[0].about
            currentUser.photo200 = user[0].photo200
            userInfoViewModel = currentUser
        } catch {}
    }
}
