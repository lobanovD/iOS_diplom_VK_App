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
                case presentNewsFeed(feed: FeedResponceWrapped)
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
    struct Cell: FeedCellViewModel {
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
    }
    
    let cells: [Cell]
}


struct FeedResponceWrapped: Decodable {
    let response: FeedResponce
}

struct FeedResponce: Decodable {
    var items: [FeedItem]
//    var profiles: [Profile]
//    var groups: [Group]
}

struct FeedItem: Decodable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
}

struct CountableItem: Decodable {
    let count: Int
}
