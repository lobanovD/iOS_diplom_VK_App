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
          
      case .some:
          print("some")
          presenter?.presentData(response: .some)
      case .getFeed:
          print(".getFeed Interactor")
          presenter?.presentData(response: .presentNewsFeed)
      }
      
      
  }
  
}
