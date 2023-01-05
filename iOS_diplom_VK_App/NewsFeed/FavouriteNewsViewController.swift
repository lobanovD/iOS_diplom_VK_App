//
//  FavouriteNewsViewController.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 20.12.2022.
//

import UIKit

class FavouriteNewsViewController: UIViewController {
    
    private var feedViewModel = FeedViewModel(posts: [])
    
    // MARK: UI
    lazy var feedTableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    // MARK: Setup
    private func UISetup() {
        view.addSubviews(views: feedTableView)
        feedTableView.separatorStyle = .none
        feedTableView.backgroundColor = .clear
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.register(NewsFeedCell.self, forCellReuseIdentifier: NewsFeedCell.id)
        feedTableView.estimatedRowHeight =  UITableView.automaticDimension
        feedTableView.topToSuperview(usingSafeArea: true)
        feedTableView.bottomToSuperview(offset: VCConstants.tableViewBottomOffset, usingSafeArea: true)
        feedTableView.widthToSuperview()
    }
    
    @objc func reloadFavourite() {
        reloadData()
    }

    // MARK: View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = VCConstants.mainViewBackgroungColor
        UISetup()
        // Наблюдатели
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFavourite), name: NSNotification.Name(rawValue: VCConstants.reloadFavourite), object: nil)
       
    }
    
    private func reloadData() {
        LocalStorage.shared.getFavouritePost()
        self.feedViewModel = LocalStorage.shared.favouriteViewModel ?? FeedViewModel(posts: [])
        feedTableView.reloadData()
    }
}

extension FavouriteNewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.id, for: indexPath) as! NewsFeedCell
        guard var feedViewModel = LocalStorage.shared.favouriteViewModel?.posts[indexPath.row] else { return cell }
       
        cell.setupCell(viewModel: feedViewModel)
        cell.layoutSubviews()
        cell.tapLike = {
            LocalStorage.shared.likeStatusUpdate(index: indexPath.row, typePage: .Favourite)
            feedViewModel = (LocalStorage.shared.favouriteViewModel?.posts[indexPath.row])!
            cell.setupCell(viewModel: feedViewModel)
            NotificationCenter.default.post(name: Notification.Name(VCConstants.reloadFavourite), object: nil)
            NotificationCenter.default.post(name: Notification.Name(VCConstants.reloadNews), object: nil)
            cell.layoutSubviews()
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.posts[indexPath.row]
        return cellViewModel.totalHeight ?? 0
    }
}

