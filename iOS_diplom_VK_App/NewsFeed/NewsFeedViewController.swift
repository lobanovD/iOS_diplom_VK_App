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

protocol NewsFeedDisplayLogic: AnyObject {
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}



class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic {
    
    var interactor: NewsFeedBusinessLogic?
    var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
    var refreshControl:UIRefreshControl!
    
    private var feedViewModel = FeedViewModel(cells: [])
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()


        
        feedTableView.separatorStyle = .none
        feedTableView.backgroundColor = .clear
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        //tableView.register(UINib(nibName: "NewsFeedCell", bundle: nil), forCellReuseIdentifier: NewsFeedCell.cellId)
        feedTableView.register(NewsFeedCell.self, forCellReuseIdentifier: NewsFeedCell.id)
        

        view.addSubview(feedTableView)
  
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)

        feedTableView.estimatedRowHeight =  UITableView.automaticDimension
        
        refreshControl = UIRefreshControl()
                refreshControl.attributedTitle = NSAttributedString(string: "Идет обновление...")
        refreshControl.addTarget(self, action: #selector(feedRefresh), for: UIControl.Event.valueChanged)
        feedTableView.addSubview(refreshControl)
        
    
    }
    
    @objc func feedRefresh() {
        interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)
        self.feedTableView.reloadData()
        refreshControl.endRefreshing()
        }
    

    

    
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
        
        switch viewModel {
       
        case .displayNewsFeed(feedViewModel: let feedViewModel):
            self.feedViewModel = feedViewModel
            feedTableView.reloadData()
        }
        
    }
    
    // MARK: UI
    
    private lazy var feedTableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), style: .plain)
        return table
    }()
    


    
}


extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.id, for: indexPath) as! NewsFeedCell
        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.setupCell(viewModel: cellViewModel)
        cell.layoutSubviews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.totalHeight
    }
}
