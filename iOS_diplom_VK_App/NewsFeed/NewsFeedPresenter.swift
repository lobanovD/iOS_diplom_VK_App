//
//  NewsFeedPresenter.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 11.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
    func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
    weak var viewController: NewsFeedDisplayLogic?
    
    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        
        switch response {
            
            
        case .saveAndPresentNewsFeed(feed: let feed):
            
          
            let posts = feed.response.items.map { feedItem in
                postViewModel(feedItem: feedItem, profiles: feed.response.profiles, group: feed.response.groups)
            }
            
          
            
            
            for post in posts {
//                guard
//                    let postId = post.postID,
//                    let sourceId = post.sourceID,
//                    let text = post.text,
//                    let date = post.date,
//                    let commentsCount = post.comments,
//                    let likesCount = post.likes,
//                    let userLikes = post.userLikes,
//                    let userCanLike = post.canLike,
//                    let repostsCount = post.shares,
//                    let viewsCount = post.views,
//                    let iconUrlString = post.iconUrlString,
//                    let name = post.name,
//                    let totalHeight = post.totalHeight,
//                    let photoAttachmentURL = post.photoAttachment?.photoUrlString,
//                    let photoAttachmentWidth = post.photoAttachment?.width,
//                    let photoAttachmentHeight = post.photoAttachment?.height
//
//
//                else { continue }
              
                
//                let currentPost = FeedPost(sourceId: sourceId,
//                                           postId: postId,
//                                           text: text,
//                                           date: date,
//                                           commentsCount: commentsCount,
//                                           likesCount: likesCount,
//                                           userLikes: userLikes,
//                                           userCanLike: userCanLike,
//                                           repostsCount: repostsCount,
//                                           viewsCount: viewsCount,
//                                           iconUrlString: iconUrlString,
//                                           name: name,
//                                           totalHeight: totalHeight,
//                                           photoAttachmentURL: photoAttachmentURL,
//                                           photoAttachmentWidth: photoAttachmentWidth,
//                                           photoAttachmentHeight: photoAttachmentHeight
//                )
                
                
                
//                let currentPost = FeedPost(sourceId: post.sourceID ?? 0,
//                                           postId: post.postID ?? 0,
//                                           text: post.text ?? "",
//                                           date: post.date ?? 0,
//                                           commentsCount: post.comments ?? 0,
//                                           likesCount: post.likes ?? 0,
//                                           userLikes: post.userLikes ?? 0,
//
//                                           repostsCount: post.shares ?? 0,
//                                           viewsCount: post.views ?? 0,
//                                           iconUrlString: post.iconUrlString ?? "",
//                                           name: post.name ?? "",
//                                           totalHeight: post.totalHeight ?? .zero,
//                                           photoAttachmentURL: post.photoAttachment?.photoUrlString ?? "",
//                                           photoAttachmentWidth: post.photoAttachment?.width ?? 0,
//                                           photoAttachmentHeight: post.photoAttachment?.height ?? 0
//                )
                
                let currentPost = FeedPost(sourceId: post.sourceID ?? 0, postId: post.postID ?? 0, text: post.text ?? "", date: post.date ?? 0, commentsCount: post.comments ?? 0, likesCount: post.likes ?? 0, userLikes: post.userLikes ?? 0, userCanLike: post.canLike ?? 0, repostsCount: post.shares ?? 0, viewsCount: post.views ?? 0, iconUrlString: post.iconUrlString ?? "", name: post.name ?? "", totalHeight: post.totalHeight ?? .zero, photoAttachmentURL: post.photoAttachment?.photoUrlString ?? "", photoAttachmentWidth: post.photoAttachment?.width ?? 0, photoAttachmentHeight: post.photoAttachment?.height ?? 0)
                
                
                
               
                LocalStorage.shared.addPostsToLocalStorage(post: currentPost)
            }

            
            // тут идет получение данных из бд
 
            LocalStorage.shared.getFeedModel()

            guard let feedViewModel = LocalStorage.shared.feedViewModel else { return }



            // и отображение их в контроллере
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayNewsFeed(feedViewModel: feedViewModel))

        }
    }
    
    private func postViewModel(feedItem: FeedItem, profiles: [Profile], group: [Group]) -> FeedViewModel.Post {
        
        let profile = self.profile(sourceID: feedItem.sourceId ?? 0, profiles: profiles, groups: group)
        
//        let vkDateFormater = VKDateFormater()
//        let date = vkDateFormater.formateDate(date: feedItem.date ?? 0)
        
        let photoAttacment = self.photoAttachment(feedItem: feedItem)
        
        let cellHeightCalc = CalculateCellHeight()
        
        let cellHeight = cellHeightCalc.calculateCellTotalHeight(photoAttachment: photoAttacment,
                                                                 text: feedItem.text)
        return FeedViewModel.Post.init(iconUrlString: profile?.photo ?? "",
                                       name: profile?.name,
                                       date: feedItem.date,
                                       text: feedItem.text,
                                       likes: feedItem.likes?.count,
                                       userLikes: feedItem.likes?.userLikes ,
                                       canLike: feedItem.likes?.canLike,
                                       comments: feedItem.comments?.count,
                                       shares: feedItem.reposts?.count,
                                       views: feedItem.views?.count,
                                       photoAttachment: photoAttacment,
                                       totalHeight: cellHeight,
                                       postID: feedItem.postId,
                                       sourceID: feedItem.sourceId
        )
    }
    
    private func profile(sourceID: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable? {
        
        let profilesOrGroups: [ProfileRepresentable] = sourceID > 0 ? profiles : groups
        let currentSourceID = sourceID > 0 ? sourceID : -sourceID
        let profileRepresentable = profilesOrGroups.first { profileRepresentable -> Bool in
            profileRepresentable.id == currentSourceID
        }
        return profileRepresentable
    }
    
    private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedPostPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ attachment in
            attachment.photo
        }), let firstPhoto = photos.first else { return nil }
        
        return FeedViewModel.FeedPostPhotoAttachment(photoUrlString: firstPhoto.url, width: firstPhoto.width, height: firstPhoto.height)
    }
}
