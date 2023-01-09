//
//  UserProfileViewController.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 02.10.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import TinyConstraints

protocol UserProfileDisplayLogic: AnyObject {
    func displayData(viewModel: UserProfile.Model.ViewModel.ViewModelData)
}

final class UserProfileViewController: UIViewController, UserProfileDisplayLogic, ProfileHeaderViewDelegate {
    
    var interactor: UserProfileBusinessLogic?
    private var userInfoViewModel = UserInfoViewModel()
    private var wallViewModel = WallViewModel(posts: [])
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = UserProfileInteractor()
        let presenter             = UserProfilePresenter()
        viewController.interactor = interactor
        interactor.presenter      = presenter
        presenter.viewController  = viewController
    }
    
    // MARK: Routing
    func didTapOnPhotoStackView() {
        let photoVC = UserPhotoViewController()
        photoVC.title = VCConstants.photoTitle
        self.navigationController?.pushViewController(photoVC, animated: true)
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = VCConstants.mainViewBackgroungColor
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        interactor?.makeRequest(request: UserProfile.Model.Request.RequestType.getUserInfo)
        interactor?.makeRequest(request: UserProfile.Model.Request.RequestType.getWall)
        setupUserProfileTable()
    }
    
    // MARK: UI
    let userProfileTable = UITableView(frame: .zero, style: .grouped)
    
    // MARK: Setup
    func displayData(viewModel: UserProfile.Model.ViewModel.ViewModelData) {
        switch viewModel {
            
        case .displayUserInfo(viewModel: let model):
            self.userInfoViewModel = model
            LocalStorage.shared.getFirstPhotos()
            self.userProfileTable.reloadData()
            
        case .displayWall(viewModel: let viewModel):
            self.wallViewModel = viewModel
            self.userProfileTable.reloadData()
        }
    }
    
    private func setupUserProfileTable() {
        view.addSubviews(views: userProfileTable)
        userProfileTable.delegate = self
        userProfileTable.dataSource = self
        userProfileTable.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.id)
        userProfileTable.register(WallCell.self, forCellReuseIdentifier: WallCell.id)
        userProfileTable.topToSuperview(usingSafeArea: true)
        userProfileTable.bottomToSuperview(offset: VCConstants.tableViewBottomOffset, usingSafeArea: true)
        userProfileTable.widthToSuperview()
    }
}

extension UserProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wallViewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WallCell.id, for: indexPath) as! WallCell
        let wallViewModel = self.wallViewModel.posts[indexPath.row]
        cell.setupCell(viewModel: wallViewModel)
        cell.layoutSubviews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = ProfileHeaderView()
            headerView.delegate = self
            headerView.setupHeader(viewModel: userInfoViewModel)
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = wallViewModel.posts[indexPath.row]
        return cellViewModel.totalHeight ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
