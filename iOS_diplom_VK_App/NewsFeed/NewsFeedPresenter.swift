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
          
      case .some:
          print(".some Presenter")
          viewController?.displayData(viewModel: .some)
      case .presentNewsFeed:
          print(".presentNewsFeed Presenter")
          viewController?.displayData(viewModel: .displayNewsFeed)
      }
  
  }
    
    
  
}
