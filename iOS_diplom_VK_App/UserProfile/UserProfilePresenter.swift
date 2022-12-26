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
      case .presentUserInfo(user: let user):
          let avatar = user.response[0].photo200
          let firstName = user.response[0].firstName
          let lastName =  user.response[0].lastName
          let currentUser = UserInfoViewModel(firstName: firstName, lastName: lastName, photo200: avatar)
        
          viewController?.displayData(viewModel: UserProfile.Model.ViewModel.ViewModelData.displayUserInfo(viewModel: currentUser))
      }
  }
}
