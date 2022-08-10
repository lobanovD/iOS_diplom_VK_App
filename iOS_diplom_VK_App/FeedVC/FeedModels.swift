//
//  FeedModels.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 10.08.2022.
//

import Foundation

struct FeedResponceWrapped: Decodable {
    let response: FeedResponce
}

struct FeedResponce: Decodable {
    var items: [FeedItem]
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
