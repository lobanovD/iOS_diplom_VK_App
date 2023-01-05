//
//  NewsFeedInteractor.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 11.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
    func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {
    
    var presenter: NewsFeedPresentationLogic?
    var service: NewsFeedService?
    
    func makeRequest(request: NewsFeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsFeedService()
        }
        
        switch request {
        case .getNewsFeed:
            NetworkService.shared.getFeed { [weak self] responce in
                guard let feedResponse = responce else { return }
 
                self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.saveAndPresentNewsFeed(feed: feedResponse))
            }
            // Очищаем фотографии пользователя
            LocalStorage.shared.deleteAllPhoto()
            
            // Сразу запрашиваем данные о пользователе и его фотографии
            DispatchQueue.global(qos: .background).async {
                NetworkService.shared.getUserProfile { responce in
                    // сохраняем в Local Storage
                    guard let responce = responce?.response[0] else { return }
                    let user = UserInfo(id: responce.id, firstName: responce.firstName, lastName: responce.lastName, about: responce.about, status: responce.status, photo200: responce.photo200)
                    LocalStorage.shared.addUserInfo(user: user)
                }
                
                // Получаем фотографии пользователя
                NetworkService.shared.getAllPhoto { photos in
                    guard let items = photos?.response.items else { return }
                    for item in items {
                        for size in item.sizes {
                            if size.type == "r" {
                                // Записываем ссылки на фотографии в Local Storage
                                let photo = UserPhotos(id: item.id, url: size.url)
                                LocalStorage.shared.addUserPhotos(photo: photo)
                            }
                        }
                    }
                }
                
            }
           
        }
    }
}
