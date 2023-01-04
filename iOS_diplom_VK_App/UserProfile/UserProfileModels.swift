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
    let response: [UserProfileResponse]
}



struct UserProfileResponse: Decodable {
    var id: Int
    var firstName: String
    var lastName: String
    var about: String
    var status: String
    var photo200: String
}

struct UserInfoViewModel {
    var firstName: String?
    var lastName: String?
    var about: String?
    var status: String?
    var photo200: String?
}

// MARK: - Photos
struct Photos: Codable {
    let response: PhotoResponse
}

// MARK: - Response
struct PhotoResponse: Codable {
    let count: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let albumId, date, id, ownerId: Int
    let lat, long: Double?
    let sizes: [Size]
    let text: String
    let hasTags: Bool
    let postId: Int?
    let squareCrop: String?

    enum CodingKeys: String, CodingKey {
        case albumId
        case date, id
        case ownerId
        case lat, long, sizes, text
        case hasTags
        case postId
        case squareCrop
    }
}

// MARK: - Size
struct Size: Codable {
    let height: Int
    let type: String
    let width: Int
    let url: String
}

//struct PhotosViewModel {
//    var photos: [UserPhoto]
//}
//struct UserPhoto {
//    var id: Int?
//    var url: String?
//}

