//
//  UserProfilePresenter.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 02.10.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol UserProfilePresentationLogic {
  func presentData(response: UserProfile.Model.Response.ResponseType)
}

class UserProfilePresenter: UserProfilePresentationLogic {
  weak var viewController: UserProfileDisplayLogic?
  
  func presentData(response: UserProfile.Model.Response.ResponseType) {
     
      switch response {
      case .presentUserInfo(user: _):
          
          // Запрашиваем данные из Local Storage
          LocalStorage.shared.getUserModel()
          guard let currentUserViewModel = LocalStorage.shared.userInfoViewModel else { return }
        
          viewController?.displayData(viewModel: UserProfile.Model.ViewModel.ViewModelData.displayUserInfo(viewModel: currentUserViewModel))
      }
  }
}
