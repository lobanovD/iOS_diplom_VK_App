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
          case getWall
      }
    }
    struct Response {
      enum ResponseType {
        case presentUserInfo(user: UserProfileResponseWrapped)
        case presentWall(wall: UserWallResponseWrapped)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayUserInfo(viewModel: UserInfoViewModel)
        case displayWall(viewModel: WallViewModel)
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

struct Photos: Codable {
    let response: PhotoResponse
}

struct PhotoResponse: Codable {
    let count: Int
    let items: [Item]
}

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

struct Size: Codable {
    let height: Int
    let type: String
    let width: Int
    let url: String
}

//// MARK: - UserWallResponseWrapped
//struct UserWallResponseWrapped: Decodable {
//    let response: UserWallResponse
//}
//
//// MARK: - Response
//struct UserWallResponse: Decodable {
//    let count: Int
//    let items: [UserWallItem]
//}
//
//// MARK: - Item
//struct UserWallItem: Decodable {
//    let id, fromId, ownerId, date: Int
//    let canDelete, canPin: Int
//    let canEdit: Int?
//    let donut: Donut
//    let comments: Comments
//    let zoomText: Bool
//    let shortTextRate: Double
//    let attachments: [UserWallAttachment]
//    let canArchive, isArchived, isFavorite: Bool
//    let likes: Likes
//    let postSource: PostSource
//    let postType: String
//    let reposts: Reposts
//    let text: String
//    let views: Views
//    let hash: String
//}
//
//// MARK: - Comments
//struct Comments: Decodable {
//    let canPost, canClose, count: Int
//    let groupsCanPost: Bool
//}
//
//// MARK: - Donut
//struct Donut: Decodable {
//    let isDonut: Bool
//}
//
//// MARK: - Likes
//struct Likes: Decodable {
//    let canLike, count, userLikes, canPublish: Int
//}
//
//// MARK: - PostSource
//struct PostSource: Decodable {
//    let type: String
//}
//
//// MARK: - Reposts
//struct Reposts: Decodable {
//    let count, wallCount, mailCount, userReposted: Int
//}
//
//// MARK: - Views
//struct Views: Decodable {
//    let count: Int
//}
//
//
//// MARK: - Attachment
//struct UserWallAttachment: Decodable {
//    let type: String
//    let photo: UserWallPhoto
//}
//
//// MARK: - Photo
//struct UserWallPhoto: Decodable {
//    let albumId, date, id, ownerId: Int
//    let accessKey: String
//    let postId: Int
//    let sizes: [PhotoSizes]
//    let text: String
//    let hasTags: Bool
//}
//
//// MARK: - Size
//struct PhotoSizes: Decodable {
//    let height: Int
//    let type: String
//    let width: Int
//    let url: String
//}
//
//
//
//
//
//
//
////struct Attachments: Decodable {
////    let photo: UserWallPhoto?
////}
////
////struct UserWallPhoto: Decodable {
////    let sizes: [PhotoSize]
////
////    var height: Int {
////        return getSizes().height
////    }
////    var width: Int {
////        return getSizes().width
////    }
////    var url: String {
////        return getSizes().url
////    }
////
////    private func getSizes() -> PhotoSize {
////        if let sizeX = sizes.first(where: { $0.type == "x" }) {
////            return sizeX
////        } else if let fallBackSize = sizes.last {
////            return fallBackSize
////        } else {
////            return PhotoSize(type: "wrong image", url: "wrong image", width: 0, height: 0)
////        }
////    }
////}
///
///
// MARK: - UserWallResponseWrapped
struct UserWallResponseWrapped: Codable {
    let response: UserWallResponse
}

// MARK: - Response
struct UserWallResponse: Codable {
    let count: Int
    let items: [UserWallItem]
}

// MARK: - Item
struct UserWallItem: Codable {
    let id, fromId, ownerId, date: Int
    let canEdit: Int?
    let canDelete, canPin: Int
    let donut: Donut
    let comments: Comments
    let shortTextRate: Double
    let attachments: [UserWallAttachment]
    let canArchive, isArchived, isFavorite: Bool
    let likes: Likes
    let postSource: PostSource
    let postType: String
    let reposts: Reposts
    let text, hash: String
    let zoomText: Bool?
    let views: Views?
}

// MARK: - Attachment
struct UserWallAttachment: Codable {
    let type: String
    let photo: UserWallPhoto
}

// MARK: - Photo
struct UserWallPhoto: Codable {
    let albumId, date, id, ownerId: Int
    let lat: Double
    let long: Double
//    let accessKey: String
//    let postId: Int?
    let sizes: [UserWallPhotoSize]
    let squareCrop: String
    let text: String
    let hasTags: Bool
}

// MARK: - Size
struct UserWallPhotoSize: Codable {
    let height: Int
    let type: String
    let width: Int
    let url: String
}

// MARK: - Comments
struct Comments: Codable {
    let canPost, canClose, count: Int
    let groupsCanPost: Bool
}

// MARK: - Donut
struct Donut: Codable {
    let isDonut: Bool
}

// MARK: - Likes
struct Likes: Codable {
    let canLike, count, userLikes, canPublish: Int
}

// MARK: - PostSource
struct PostSource: Codable {
    let type: String
}

// MARK: - Reposts
struct Reposts: Codable {
    let count, wallCount, mailCount, userReposted: Int
}

// MARK: - Views
struct Views: Codable {
    let count: Int
}

struct WallViewModel {
    
    let posts: [Post]
    
    struct Post {
        var id: Int?
        var fromId: Int?
        var ownerId: Int?
        var date: Int?
        
//        var iconUrlString: String?
//        var name: String?

        var text: String?
        var likes: Int?
        var userLikes: Int?
//        var canLike: Int?
        var comments: Int?
        var shares: Int?
        var views: Int?
        var photoAttachment: WallPostPhotoAttachment?
        var totalHeight: CGFloat?
//        var postId: Int?
//        var sourceID: Int?
//        var current: Bool?
    }
    
    struct WallPostPhotoAttachment: CellPhotoAttachmentViewModelProtocol {
        var photoUrlString: String?
        var width: Int
        var height: Int
    }
}



