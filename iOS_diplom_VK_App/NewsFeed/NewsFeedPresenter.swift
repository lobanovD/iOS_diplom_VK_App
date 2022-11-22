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
            
        case .presentNewsFeed(feed: let feed):
            
            let cells = feed.response.items.map { feedItem in
                cellViewModel(feedItem: feedItem, profiles: feed.response.profiles, group: feed.response.groups)
            }
            
            let feedViewModel = FeedViewModel(cells: cells)
            
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayNewsFeed(feedViewModel: feedViewModel))
        }
    }
    
    private func cellViewModel(feedItem: FeedItem, profiles: [Profile], group: [Group]) -> FeedViewModel.Cell {
        
        let profile = self.profile(sourceID: feedItem.sourceId, profiles: profiles, groups: group)
        
        let vkDateFormater = VKDateFormater()
        let date = vkDateFormater.formateDate(date: feedItem.date)
        
        let photoAttacment = self.photoAttachment(feedItem: feedItem)
        
        let cellHeightCalc = CalculateCellHeight()
        
        let cellHeight = cellHeightCalc.calculateCellTotalHeight(photoAttachment: photoAttacment,
                                                                 text: feedItem.text)
        return FeedViewModel.Cell.init(iconUrlString: profile?.photo ?? "",
                                       name: profile?.name ?? "Имя группы не получено",
                                       date: date,
                                       text: feedItem.text,
                                       likes: String(feedItem.likes?.count ?? 0),
                                       userLikes: feedItem.likes?.userLikes,
                                       comments: String(feedItem.comments?.count ?? 0),
                                       shares: String(feedItem.reposts?.count ?? 0),
                                       views: String(feedItem.views?.count ?? 0),
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
    
    private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ attachment in
            attachment.photo
        }), let firstPhoto = photos.first else { return nil }
        
        return FeedViewModel.FeedCellPhotoAttachment(photoUrlString: firstPhoto.url, width: firstPhoto.width, height: firstPhoto.height)
    }
}
