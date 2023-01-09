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

final class UserProfilePresenter: UserProfilePresentationLogic {
    weak var viewController: UserProfileDisplayLogic?
    
    func presentData(response: UserProfile.Model.Response.ResponseType) {
        
        switch response {
        case .presentUserInfo(user: _):
            
            // Запрашиваем данные о пользователе из Local Storage 
            LocalStorage.shared.getUserModel()
            guard let currentUserViewModel = LocalStorage.shared.userInfoViewModel else { return }
            viewController?.displayData(viewModel: UserProfile.Model.ViewModel.ViewModelData.displayUserInfo(viewModel: currentUserViewModel))
            
        case .presentWall(wall: let wall):
            
            // удаляем все записи со стены из локального хранилища
            LocalStorage.shared.deleteAllWallPosts()
            
            let wallPosts = wall.response.items.map { wallItem in
                postViewModel(userWallItem: wallItem, profiles: wall.response.profiles, groups: wall.response.groups)
            }
            
            for post in wallPosts {
                let currentPost = WallPost(id: post.id ?? 0,
                                           text: post.text ?? "",
                                           date: post.date ?? 0,
                                           totalHeight: post.totalHeight ?? .zero,
                                           name: post.name ?? "",
                                           photo: post.photo ?? "",
                                           likesCount: post.likes ?? 0,
                                           userLikes: post.userLikes ?? 0,
                                           commentsCount: post.comments ?? 0,
                                           repostsCount: post.shares ?? 0,
                                           viewsCount: post.views ?? 0,
                                           photoAttachmentURL: post.photoAttachment?.photoUrlString ?? "",
                                           photoAttachmentWidth: post.photoAttachment?.width ?? 0,
                                           photoAttachmentHeight: post.photoAttachment?.height ?? 0
                )
                // добавляем в локальное хранилище
                LocalStorage.shared.addWallPostsToLocalStorage(post: currentPost)
            }
            
            // тут идет получение данных из бд
            LocalStorage.shared.getWallModel()
            
            guard let wallViewModel = LocalStorage.shared.wallViewModel else { return }
            
            // и отображение их в контроллере
            viewController?.displayData(viewModel: UserProfile.Model.ViewModel.ViewModelData.displayWall(viewModel: wallViewModel))
        }
    }
    
    private func postViewModel(userWallItem: UserWallItem, profiles: [UserWallProfile], groups: [UserWallGroup]) -> WallViewModel.Post {
        let profile = self.profile(sourceID: userWallItem.fromId , profiles: profiles, groups: groups)
        let photoAttacment = self.photoAttachment(userWallItem: userWallItem)
        let cellHeightCalc = CalculateCellHeight()
        let cellHeight = cellHeightCalc.calculateCellTotalHeight(photoAttachment: photoAttacment, text: userWallItem.text)
        var model = WallViewModel.Post()
        model.id = userWallItem.id
        model.fromId = userWallItem.fromId
        model.ownerId = userWallItem.ownerId
        model.date = userWallItem.date
        model.text = userWallItem.text
        model.likes = userWallItem.likes.count
        model.userLikes = userWallItem.likes.userLikes
        model.comments = userWallItem.comments.count
        model.shares = userWallItem.reposts.count
        model.views = userWallItem.views?.count
        model.photoAttachment = photoAttacment
        model.totalHeight = cellHeight
        model.name = profile?.name
        model.photo = profile?.photo
        return model
    }
    
    private func photoAttachment(userWallItem: UserWallItem) -> WallViewModel.WallPostPhotoAttachment? {
        let photos = userWallItem.attachments.compactMap({ attachment in
            attachment.photo
        })
        let photo = photos.first?.sizes[3]
        return WallViewModel.WallPostPhotoAttachment(photoUrlString: photo?.url, width: photo?.width ?? 0, height: photo?.height ?? 0)
    }
    
    private func profile(sourceID: Int, profiles: [UserWallProfile], groups: [UserWallGroup]) -> WallProfileRepresentable? {
        let profilesOrGroups: [WallProfileRepresentable] = sourceID > 0 ? profiles : groups
        let currentSourceID = sourceID > 0 ? sourceID : -sourceID
        let profileRepresentable = profilesOrGroups.first { profileRepresentable -> Bool in
            profileRepresentable.id == currentSourceID
        }
        return profileRepresentable
    }
}
