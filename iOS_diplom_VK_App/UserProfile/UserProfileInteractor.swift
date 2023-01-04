//
//  UserProfileInteractor.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 02.10.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol UserProfileBusinessLogic {
  func makeRequest(request: UserProfile.Model.Request.RequestType)
}

class UserProfileInteractor: UserProfileBusinessLogic {

  var presenter: UserProfilePresentationLogic?
  var service: UserProfileService?
  
  func makeRequest(request: UserProfile.Model.Request.RequestType) {
    if service == nil {
      service = UserProfileService()
    }
      
      switch request {
      case .getUserInfo:
          
          NetworkService.shared.getUserProfile { [weak self] responce in
              guard let responce = responce?.response[0] else { return }
              let user = UserInfo(id: responce.id, firstName: responce.firstName, lastName: responce.lastName, about: responce.about, status: responce.status, photo200: responce.photo200)
              LocalStorage.shared.addUserInfo(user: user)
              
              let userModel = UserProfileResponseWrapped(response: [responce])
              
              // Заполняем массив фотографий для хедера страницы пользователя
              LocalStorage.shared.getFirstPhotos()
              
              self?.presenter?.presentData(response: UserProfile.Model.Response.ResponseType.presentUserInfo(user: userModel))
          }
      }
  }
}
