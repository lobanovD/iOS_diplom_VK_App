//
//  NewsFeedViewController.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 11.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Foundation
import TinyConstraints
import RealmSwift

protocol NewsFeedDisplayLogic: AnyObject {
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic {
    
    var interactor: NewsFeedBusinessLogic?
    var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
    var refreshControl:UIRefreshControl!
    
    private var feedViewModel = FeedViewModel(posts: [])
    
    let defaults = UserDefaults.standard
    
   
    
    private func getNews() {
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)
    }
    
    // MARK: Setup

    private func setup() {
        let viewController        = self
        let interactor            = NewsFeedInteractor()
        let presenter             = NewsFeedPresenter()
        let router                = NewsFeedRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: Routing
    

    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        getNews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        setup()
        tableSetup()
//        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)
//        refreshControlSetup()
        
        // Наблюдатели
        NotificationCenter.default.addObserver(self, selector: #selector(reloadNews), name: NSNotification.Name(rawValue: "reloadNews"), object: nil)
        
        
    }
    
 
    
   
    
    
    private func tableSetup() {
        view.addSubview(feedTableView)
        feedTableView.separatorStyle = .none
        feedTableView.backgroundColor = .clear
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.register(NewsFeedCell.self, forCellReuseIdentifier: NewsFeedCell.id)
        feedTableView.estimatedRowHeight =  UITableView.automaticDimension
        feedTableView.topToSuperview(usingSafeArea: true)
        feedTableView.bottomToSuperview(offset: FeedVCConstants.tableViewBottomOffset, usingSafeArea: true)
        feedTableView.widthToSuperview()
        
       
        
    }
    
    
    @objc func reloadNews() {
        getNews()
        self.feedTableView.reloadData()
        
    }
    
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
        
        switch viewModel {
            
        case .displayNewsFeed(feedViewModel: let feedViewModel):
            self.feedViewModel = feedViewModel
            feedTableView.reloadData()
            print("таблица загружена")
            
            // перемещаем область видимости на последний пост
            print("2текущее значение", UserDefaults.standard.integer(forKey: "index"))
            
//            if UserDefaults.standard.integer(forKey: "index") == nil {
//                feedTableView.scrollToRow(at: [0, feedViewModel.posts.count - 1], at: .top, animated: false)
//            } else if UserDefaults.standard.integer(forKey: "index") == 1 || UserDefaults.standard.integer(forKey: "index") == 0 {
//                feedTableView.scrollToRow(at: [0, feedViewModel.posts.count - (feedViewModel.posts.count - UserDefaults.standard.integer(forKey: "index") - 1)], at: .top, animated: false)
//            } else {
//                feedTableView.scrollToRow(at: [0, feedViewModel.posts.count - (feedViewModel.posts.count - UserDefaults.standard.integer(forKey: "index") + 1)], at: .top, animated: false)
//            }
            
            if UserDefaults.standard.integer(forKey: "index") != 0 {
                feedTableView.scrollToRow(at: [0, feedViewModel.posts.count - (feedViewModel.posts.count - UserDefaults.standard.integer(forKey: "index"))], at: .top, animated: false)
            }
            
        }
    }
    
    // MARK: UI
    lazy var feedTableView: UITableView = {
        let table = UITableView()
        return table
    }()
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedViewModel.posts.count
    }
    
  
 
    
 
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.id, for: indexPath) as! NewsFeedCell
        guard var feedViewModel = LocalStorage.shared.feedViewModel?.posts[indexPath.row] else { return cell }
               
        cell.setupCell(viewModel: feedViewModel)
        cell.layoutSubviews()
        
        
              
        
        
        
        
        
        cell.tapLike = {
            LocalStorage.shared.likeStatusUpdate(index: indexPath.row)
            feedViewModel = (LocalStorage.shared.feedViewModel?.posts[indexPath.row])!
            cell.setupCell(viewModel: feedViewModel)
            tableView.reloadRows(at: [indexPath], with: .none)
            cell.layoutSubviews()
            }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.posts[indexPath.row]
        return cellViewModel.totalHeight ?? 0
    }
    
    
//    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//
//        let currentPostIndex = UserDefaults.standard.integer(forKey: "index")
//
//            UserDefaults.standard.set(indexPath.row, forKey: "index")
//            print("текущее значение", UserDefaults.standard.integer(forKey: "index"))
//
//    }
//
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let currentPostIndex = UserDefaults.standard.integer(forKey: "index")
//
//            UserDefaults.standard.set(indexPath.row, forKey: "index")
//            print("текущее значение", UserDefaults.standard.integer(forKey: "index"))
//
//    }
    


    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let firstVisibleIndexPath = self.feedTableView.indexPathsForVisibleRows?[0]
        print("First visible cell section=\(firstVisibleIndexPath?.section), and row=\(firstVisibleIndexPath?.row)")
        
        UserDefaults.standard.set(firstVisibleIndexPath?.row, forKey: "index")
        print("текущее значение", UserDefaults.standard.integer(forKey: "index"))
    }
 
    
}
