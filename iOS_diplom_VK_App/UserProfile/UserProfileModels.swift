//
//  UserProfileModels.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 02.10.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum UserProfile {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getUserInfo
      }
    }
    struct Response {
      enum ResponseType {
        case presentUserInfo(user: UserProfileResponseWrapped)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayUserInfo(viewModel: UserInfoViewModel)
      }
    }
  }
  
}

struct UserProfileResponseWrapped: Decodable {
    let response: UserProfileResponse
}

struct UserProfileResponse: Decodable {
    var firstName: String
    var lastName: String
    var relation: Int
}

struct UserInfoViewModel {
    var firstName: String?
    var lastName: String?
}
