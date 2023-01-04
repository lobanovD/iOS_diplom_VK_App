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

class UserProfileViewController: UIViewController, UserProfileDisplayLogic {
    
    var interactor: UserProfileBusinessLogic?
    var router: (NSObjectProtocol & UserProfileRoutingLogic)?
    private var userInfoViewModel = UserInfoViewModel()
    
    
    // MARK: Object lifecycle
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = UserProfileInteractor()
        let presenter             = UserProfilePresenter()
        let router                = UserProfileRouter()
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
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        setup()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        interactor?.makeRequest(request: UserProfile.Model.Request.RequestType.getUserInfo)
        setupUserProfileTable()
        
    }
    
    // MARK: UI
    let userProfileTable = UITableView(frame: .zero, style: .grouped)
    
    
    // MARK: Setup
    func displayData(viewModel: UserProfile.Model.ViewModel.ViewModelData) {
        switch viewModel {
            
        case .displayUserInfo(viewModel: let model):
            self.userInfoViewModel = model
            print("данные получены")
            LocalStorage.shared.getFirstPhotos()
            self.userProfileTable.reloadData()
            
            
            
        }
    }
    
    

    
    
    private func setupUserProfileTable() {
        view.addSubviews(views: userProfileTable)
        userProfileTable.delegate = self
        userProfileTable.dataSource = self
        userProfileTable.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.id)
//        userProfileTable.estimatedRowHeight =  UITableView.automaticDimension
//        userProfileTable.sectionHeaderHeight = UITableView.automaticDimension
//        userProfileTable.estimatedSectionHeaderHeight = 500


        userProfileTable.topToSuperview(usingSafeArea: true)
//         ОБР
//        АТИТЬ
//        ВНИМАНИЕ на офсет ниже
        userProfileTable.bottomToSuperview(offset: FeedVCConstants.tableViewBottomOffset, usingSafeArea: true)
        userProfileTable.widthToSuperview()
    }
    
    
}




extension UserProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
                return 20
            } else {
                return 0
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ddd")
        //        cell.textLabel?.text = self.userInfoViewModel.firstName
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = ProfileHeaderView()
            
            headerView.setupHeader(viewModel: userInfoViewModel)
            
            return headerView
            
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension

    }
    
    
    
    

    
}
