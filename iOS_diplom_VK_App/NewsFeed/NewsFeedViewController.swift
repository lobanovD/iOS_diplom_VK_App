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
        UISetup()
//        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)
//        refreshControlSetup()
        
        // Наблюдатели
        NotificationCenter.default.addObserver(self, selector: #selector(reloadNews), name: NSNotification.Name(rawValue: "reloadNews"), object: nil)
        
        
    }
    
 
    
   
    
    
    private func UISetup() {
        view.addSubviews(views: feedTableView, allertAboutNewFeed)
        feedTableView.separatorStyle = .none
        feedTableView.backgroundColor = .clear
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.register(NewsFeedCell.self, forCellReuseIdentifier: NewsFeedCell.id)
        feedTableView.estimatedRowHeight =  UITableView.automaticDimension
        feedTableView.topToSuperview(usingSafeArea: true)
        feedTableView.bottomToSuperview(offset: FeedVCConstants.tableViewBottomOffset, usingSafeArea: true)
        feedTableView.widthToSuperview()
        
        allertAboutNewFeed.topToSuperview(usingSafeArea: true)
        allertAboutNewFeed.leftToSuperview(offset: 50)
        allertAboutNewFeed.rightToSuperview(offset: -50)
        
       
        
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
            
            // Сохраняем количество постов в память
            if defaults.integer(forKey: "oldPostsCount") ==  0 {
                defaults.set(feedViewModel.posts.count, forKey: "newPostCount")
                defaults.set(feedViewModel.posts.count, forKey: "oldPostsCount")
            } else {
                let oldPostCountForSave = defaults.integer(forKey: "newPostCount")
                let newPostCountForSave = feedViewModel.posts.count
                defaults.set(oldPostCountForSave, forKey: "oldPostCount")
                defaults.set(newPostCountForSave, forKey: "newPostCount")
            }
            
            // Получаем индекс последнего просмотренного сообщения из памяти
            let finalPostIndex = defaults.integer(forKey: "index")
            // Получаем значение количества постов, которое было до обновления таблицы
            let oldPostCount = defaults.integer(forKey: "oldPostCount")
            // Перемещаем область видимости на последний просмотренный пост
            
            feedTableView.scrollToRow(at: [0, feedViewModel.posts.count - (oldPostCount - finalPostIndex)], at: .top, animated: false)
            // Показываем аллерт о новых сообщениях
            let newPostCount = feedViewModel.posts.count
            if newPostCount > oldPostCount {
                allertAboutNewFeed.isHidden = false
            }
        }
    }
    
    // MARK: UI
    lazy var feedTableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    private lazy var allertAboutNewFeed: UILabel = {
        let allertAboutNewFeed = UILabel()
        allertAboutNewFeed.text = "Свежие новости"
        allertAboutNewFeed.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.4965524673, blue: 0.7551663518, alpha: 1)
        allertAboutNewFeed.textAlignment = .center
        allertAboutNewFeed.textColor = .white
        allertAboutNewFeed.layer.cornerRadius = 5
        allertAboutNewFeed.layer.borderWidth = 1
        allertAboutNewFeed.layer.borderColor = CGColor(srgbRed: 45, green: 127, blue: 193, alpha: 1)
        allertAboutNewFeed.clipsToBounds = true
        allertAboutNewFeed.isHidden = true
        return allertAboutNewFeed
    }()
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.posts.count
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
    
    



    // Сохраняем индекс поста, на котором находится пользователь
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let firstVisibleIndexPath = self.feedTableView.indexPathsForVisibleRows?[0]
        defaults.set(firstVisibleIndexPath?.row, forKey: "index")
        
        // Скрываем аллерт о новых постах при показе самого "свежего" поста
        if firstVisibleIndexPath == [0, 0] {
            allertAboutNewFeed.isHidden = true
        }
    }
 
    
}
