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
              guard let responce = responce else { return }
              self?.presenter?.presentData(response: UserProfile.Model.Response.ResponseType.presentUserInfo(user: responce))
          }
      }
  }
}
