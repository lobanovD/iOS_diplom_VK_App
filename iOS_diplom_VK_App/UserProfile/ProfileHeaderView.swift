//
//  ProfileHeaderView.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 18.10.2022.
//

import UIKit
import TinyConstraints

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    static let id = "ProfileHeaderView"
    var avatar: String?
    
    // MARK: Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(views: bottomView, avatarImage)
//        bottomView.addSubviews(views: )
        setup()
        contentView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
       
        
    }
    
    //UI
    private lazy var bottomView: UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = .white
        bottomView.layer.cornerRadius = 20
        bottomView.clipsToBounds = true
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return bottomView
    }()
    
    lazy var avatarImage: WebImageView = {
        let avatarImage = WebImageView()
        return avatarImage
    }()
    
    func setupHeader(viewModel: UserInfoViewModel) {
        
        self.avatarImage.set(imageUrl: viewModel.photo200)
        
    }
    

    
    
    // Constraints
    private func setup() {
        bottomView.bottomToSuperview()
        bottomView.leadingToSuperview()
        bottomView.trailingToSuperview()
        bottomView.height(150)
        
        avatarImage.height(150)
        avatarImage.width(150)
        avatarImage.layer.cornerRadius = 75
        avatarImage.clipsToBounds = true
        avatarImage.layer.borderWidth = 2
        avatarImage.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        avatarImage.centerX(to: bottomView)
        avatarImage.bottomToTop(of: bottomView, offset: 60)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
