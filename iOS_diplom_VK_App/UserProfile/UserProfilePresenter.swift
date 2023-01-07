//
//  UserProfilePresenter.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 02.10.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol UserProfilePresentationLogic {
  func presentData(response: UserProfile.Model.Response.ResponseType)
}

class UserProfilePresenter: UserProfilePresentationLogic {
  weak var viewController: UserProfileDisplayLogic?
  
  func presentData(response: UserProfile.Model.Response.ResponseType) {
     
      switch response {
      case .presentUserInfo(user: _):
          
          // Запрашиваем данные о пользователе из Local Storage 
          LocalStorage.shared.getUserModel()
          guard let currentUserViewModel = LocalStorage.shared.userInfoViewModel else { return }
          viewController?.displayData(viewModel: UserProfile.Model.ViewModel.ViewModelData.displayUserInfo(viewModel: currentUserViewModel))
          
      case .presentWall(wall: let wall):
          
          let wallPosts = wall.response.items.map { wallItem in
//              wallItem.
              postViewModel(userWallItem: wallItem)

          }
          
              
              
//              for post in posts {
//
//                  let currentPost = FeedPost(sourceId: post.sourceID ?? 0, postId: post.postID ?? 0, text: post.text ?? "", date: post.date ?? 0, commentsCount: post.comments ?? 0, likesCount: post.likes ?? 0, userLikes: post.userLikes ?? 0, userCanLike: post.canLike ?? 0, repostsCount: post.shares ?? 0, viewsCount: post.views ?? 0, iconUrlString: post.iconUrlString ?? "", name: post.name ?? "", totalHeight: post.totalHeight ?? .zero, photoAttachmentURL: post.photoAttachment?.photoUrlString ?? "", photoAttachmentWidth: post.photoAttachment?.width ?? 0, photoAttachmentHeight: post.photoAttachment?.height ?? 0)
//
//                  LocalStorage.shared.addPostsToLocalStorage(post: currentPost)
//              }
              
              
//              // тут идет получение данных из бд
//              LocalStorage.shared.getFeedModel()
              
//              guard let feedViewModel = LocalStorage.shared.feedViewModel else { return }
              
              // и отображение их в контроллере
//          viewController?.displayData(viewModel: UserProfile.Model.ViewModel.ViewModelData.displayWall(viewmodel: model))
      }
  }
    
    private func postViewModel(userWallItem: UserWallItem) -> WallViewModel.Post {
        
//        let profile = self.profile(sourceID: feedItem.sourceId ?? 0, profiles: profiles, groups: group)
        
        let photoAttacment = self.photoAttachment(userWallItem: userWallItem)
        
        let cellHeightCalc = CalculateCellHeight()
        
        let cellHeight = cellHeightCalc.calculateCellTotalHeight(photoAttachment: photoAttacment,
                                                                 text: userWallItem.text)
        return WallViewModel.Post.init(text:userWallItem.text)
    }
    
    private func profile(sourceID: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable? {
        
        let profilesOrGroups: [ProfileRepresentable] = sourceID > 0 ? profiles : groups
        let currentSourceID = sourceID > 0 ? sourceID : -sourceID
        let profileRepresentable = profilesOrGroups.first { profileRepresentable -> Bool in
            profileRepresentable.id == currentSourceID
        }
        return profileRepresentable
    }
    
    private func photoAttachment(userWallItem: UserWallItem) -> WallViewModel.FeedPostPhotoAttachment? {
        let photos = userWallItem.attachments.compactMap({ attachment in
            attachment.photo
        })
        let firstPhoto = photos.first?.sizes.first
        
        return WallViewModel.FeedPostPhotoAttachment(photoUrlString: firstPhoto?.url, width: firstPhoto?.width ?? 0, height: firstPhoto?.height ?? 0)
    }
}
