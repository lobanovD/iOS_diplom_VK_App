//
//  NewsFeedModels.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 11.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum NewsFeed {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getNewsFeed
            }
        }
        struct Response {
            enum ResponseType {
                case saveAndPresentNewsFeed(feed: FeedResponceWrapped)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayNewsFeed(feedViewModel: FeedViewModel)
            }
        }
    }
}

struct FeedViewModel {
    
    let posts: [Post]
    
    struct Post: FeedPostViewModel {
        
        var iconUrlString: String?
        var name: String?
        var date: Int?
        var text: String?
        var likes: Int?
        var userLikes: Int?
        var canLike: Int?
        var comments: Int?
        var shares: Int?
        var views: Int?
        var photoAttachment: FeedCellPhotoAttachmentViewModel?
        var totalHeight: CGFloat?
        var postID: Int?
        var sourceID: Int?
        var current: Bool?
    }
    
    struct FeedPostPhotoAttachment: FeedCellPhotoAttachmentViewModel {
        var photoUrlString: String?
        var width: Int
        var height: Int
    }
}

struct FeedResponceWrapped: Decodable {
    let response: FeedResponce
}

struct FeedResponce: Decodable {
    var items: [FeedItem]
    var profiles: [Profile]
    var groups: [Group]
}

struct FeedItem: Decodable {
    let sourceId: Int?
    let postId: Int?
    let text: String?
    let date: Int?
    let comments: CountableItem?
    let likes: CountableLikes?
    let reposts: CountableItem?
    let views: CountableItem?
    let attachments: [Attachment]?
}

struct CountableLikes: Decodable {
    let count: Int?
    let userLikes: Int?
    let canLike: Int?
}

struct CountableItem: Decodable {
    let count: Int?
}

struct Attachment: Decodable {
    let photo: Photo?
}

struct Photo: Decodable {
    let sizes: [PhotoSize]
    
    var height: Int {
        return getSizes().height
    }
    var width: Int {
        return getSizes().width
    }
    var url: String {
        return getSizes().url
    }
    
    private func getSizes() -> PhotoSize {
        if let sizeX = sizes.first(where: { $0.type == "x" }) {
            return sizeX
        } else if let fallBackSize = sizes.last {
            return fallBackSize
        } else {
            return PhotoSize(type: "wrong image", url: "wrong image", width: 0, height: 0)
        }
    }
}

struct PhotoSize: Decodable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}

protocol ProfileRepresentable {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
    
}

struct Profile: Decodable, ProfileRepresentable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    var name: String { return firstName + " " + lastName }
    var photo: String { return photo100 }
}

struct Group: Decodable, ProfileRepresentable {
    let id: Int
    let name: String
    let photo100: String
    var photo: String { return photo100 }
}

enum TypePage {
    case FeedNews
    case Favourite
}

