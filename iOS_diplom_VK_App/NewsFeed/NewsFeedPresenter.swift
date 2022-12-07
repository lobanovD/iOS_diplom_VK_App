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
            
//            let localStorage = LocalStorage()
            
            print(posts[0].totalHeight)
            
            for post in posts {
                guard
                    let postId = post.postID,
                    let sourceId = post.sourceID,
                    let text = post.text,
                    let date = post.date,
                    let commentsCount = post.comments,
                    let likesCount = post.likes,
                    let userLikes = post.userLikes,
                    let userCanLike = post.canLike,
                    let repostsCount = post.shares,
                    let viewsCount = post.views,
                    let iconUrlString = post.iconUrlString
                        
                        
                else {
                    print("Ошибка")
                    return }
              
                
                let currentPost = FeedPost(sourceId: sourceId,
                                           postId: postId,
                                           text: text,
                                           date: date,
                                           commentsCount: commentsCount,
                                           likesCount: likesCount,
                                           userLikes: userLikes,
                                           userCanLike: userCanLike,
                                           repostsCount: repostsCount,
                                           viewsCount: viewsCount,
                                           iconUrlString: iconUrlString)
                
                LocalStorage.shared.addPostsToLocalStorage(post: currentPost)
            }
            
//
//            self.text = text
//            self.date = date
//            self.commentsCount = commentsCount
//            self.likesCount
//            self.userLikes = userLikes
//            self.userCanLike = userCanLike
//            self.repostsCount = repostsCount
//            self.viewsCount = viewsCount
            
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
//        let date = vkDateFormater.formateDate(date: feedItem.date)
        
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
