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

protocol WallProfileRepresentable {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
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

struct UserWallResponseWrapped: Codable {
    let response: UserWallResponse
}

struct UserWallResponse: Codable {
    let count: Int
    let items: [UserWallItem]
    let profiles: [UserWallProfile]
    let groups: [UserWallGroup]
}

struct UserWallProfile: Codable, WallProfileRepresentable {
    let id, sex: Int
    let screenName: String
    let photo50, photo100: String
    let onlineInfo: OnlineInfo
    let online: Int
    let firstName, lastName: String
    let canAccessClosed, isClosed: Bool
    var photo: String { return photo50 }
    var name: String { return firstName + " " + lastName }
}

struct UserWallGroup:  Codable, WallProfileRepresentable {
    let id: Int
    let name, screenName: String
    let isClosed: Int
    let type: String
    let photo50, photo100, photo200: String
    var photo: String { return photo50 }
}

struct OnlineInfo: Codable {
    let visible: Bool
    let lastSeen: Int
    let isOnline, isMobile: Bool
}

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

struct UserWallAttachment: Codable {
    let type: String
    let photo: UserWallPhoto
}

struct UserWallPhoto: Codable {
    let albumId, date, id, ownerId: Int
    let lat: Double
    let long: Double
    let sizes: [UserWallPhotoSize]
    let squareCrop: String
    let text: String
    let hasTags: Bool
}

struct UserWallPhotoSize: Codable {
    let height: Int
    let type: String
    let width: Int
    let url: String
}

struct Comments: Codable {
    let canPost, canClose, count: Int
    let groupsCanPost: Bool
}

struct Donut: Codable {
    let isDonut: Bool
}

struct Likes: Codable {
    let canLike, count, userLikes, canPublish: Int
}

struct PostSource: Codable {
    let type: String
}

struct Reposts: Codable {
    let count, wallCount, mailCount, userReposted: Int
}

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
        var name: String?
        var photo: String?
        var text: String?
        var likes: Int?
        var userLikes: Int?
        var comments: Int?
        var shares: Int?
        var views: Int?
        var photoAttachment: WallPostPhotoAttachment?
        var totalHeight: CGFloat?
    }
    
    struct WallPostPhotoAttachment: CellPhotoAttachmentViewModelProtocol {
        var photoUrlString: String?
        var width: Int
        var height: Int
    }
}
