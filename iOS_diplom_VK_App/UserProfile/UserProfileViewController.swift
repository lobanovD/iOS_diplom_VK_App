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
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        setup()
//        setupUserProfileTable()
        
    }
    
    // UI
    let userProfileTable = UITableView(frame: .zero, style: .grouped)
    
    
    override func viewWillAppear(_ animated: Bool) {
        
            interactor?.makeRequest(request: UserProfile.Model.Request.RequestType.getUserInfo)
        setupUserProfileTable()
    }
  
  func displayData(viewModel: UserProfile.Model.ViewModel.ViewModelData) {
      switch viewModel {
          
      case .displayUserInfo(viewModel: let model):
          self.userInfoViewModel = model
          print("данные получены")
          self.userProfileTable.reloadData()
      }
  }
    

    private func setupUserProfileTable() {
        view.addSubviews(views: userProfileTable)
//        userProfileTable.separatorStyle = .none
//        userProfileTable.backgroundColor = .clear
        userProfileTable.delegate = self
        userProfileTable.dataSource = self
//        userProfileTable.register(NewsFeedCell.self, forCellReuseIdentifier: NewsFeedCell.id)
        userProfileTable.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.id)
        userProfileTable.estimatedRowHeight =  UITableView.automaticDimension
        userProfileTable.topToSuperview(usingSafeArea: true)
        userProfileTable.bottomToSuperview(offset: FeedVCConstants.tableViewBottomOffset, usingSafeArea: true)
        userProfileTable.widthToSuperview()
    }
 


  
}




extension UserProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ddd")
//        cell.textLabel?.text = self.userInfoViewModel.firstName
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.id) as! ProfileHeaderView
            
            headerView.avatarImage.image = UIImage(named: "avatar")
            
            headerView.setupHeader(viewModel: userInfoViewModel)
            
//            if let name = userInfoViewModel.firstName, let surname = userInfoViewModel.lastName {
//                headerView.fullNameLabel.text = "\(name) \(surname)"
//            }
            
            
            return headerView
            
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 250
        } else {
            return 0
        }
    }

    
    
}
