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
                    currentUser?.photo200 = user.photo200
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
    
    // Метод добавления ссылок на фотографии пользователя в локальное хранилище
    func addUserPhotos(photo: UserPhotos) {
        do {
            let realm = try Realm()
            guard realm.object(ofType: UserPhotos.self, forPrimaryKey: photo.id) == nil else {
                let currentPhoto = realm.object(ofType: UserPhotos.self, forPrimaryKey: photo.id)
                try realm.write {
                    currentPhoto?.url = photo.url
                }
                return }
            
            try realm.write {
                realm.add(photo)
            }
        } catch {}
    }
    
    // Метод получения всех фото пользователя
    func getFirstPhotos() {
        self.photosForHeader = []
        var fourPhotos: [String] = []
        do {
            let realm = try Realm()
            let photos = realm.objects(UserPhotos.self)
            
            for photo in photos {
                var currentPhotoUrl = ""
                currentPhotoUrl = photo.url
                fourPhotos.append(currentPhotoUrl)
            }
            self.photosForHeader = fourPhotos
        } catch {}
    }
    
    // Метод удаления всех фото пользователя из локального хранилища
    func deleteAllPhoto() {
        do {
            let realm = try Realm()
            let photos = realm.objects(UserPhotos.self)
            
            try realm.write {
                realm.delete(photos)
            }
        } catch {}
    }
}
