//
//  NewsFeedInteractor.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 11.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
  func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {

  var presenter: NewsFeedPresentationLogic?
  var service: NewsFeedService?
  
  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
    }
      
      switch request {
      case .getNewsFeed:
          NetworkService.shared.getFeed { [weak self] responce in
              guard let feedResponse = responce else { return }
//              presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed)
              self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feedResponse))

          }
      }
      
      
  }
  
}
