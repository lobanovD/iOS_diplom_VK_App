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
  
//  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    setup()
//  }
//  
//  required init?(coder aDecoder: NSCoder) {
//    super.init(coder: aDecoder)
//    setup()
//  }
  
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
        setup()
//        setupUserProfileTable()
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
            interactor?.makeRequest(request: UserProfile.Model.Request.RequestType.getUserInfo)
        setupUserProfileTable()
    }
  
  func displayData(viewModel: UserProfile.Model.ViewModel.ViewModelData) {
      switch viewModel {
          
      case .displayUserInfo(viewModel: let model):
          self.userInfoViewModel = model
          self.userProfileTable.reloadData()
      }
  }
    

    private func setupUserProfileTable() {
        view.addSubviews(views: userProfileTable)
        userProfileTable.separatorStyle = .none
        userProfileTable.backgroundColor = .clear
        userProfileTable.delegate = self
        userProfileTable.dataSource = self
        userProfileTable.register(NewsFeedCell.self, forCellReuseIdentifier: NewsFeedCell.id)
        userProfileTable.estimatedRowHeight =  UITableView.automaticDimension
        userProfileTable.topToSuperview(usingSafeArea: true)
        userProfileTable.bottomToSuperview(offset: FeedVCConstants.tableViewBottomOffset, usingSafeArea: true)
        userProfileTable.widthToSuperview()
        print(3456)
        print(self.userInfoViewModel.firstName)
    }
    
//MARK: UI
    private lazy var userProfileTable: UITableView = {
        let table = UITableView()
        return table
    }()
  
}


extension UserProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ddd")
        return cell
    }
    
    
}
