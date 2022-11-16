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
    
    // MARK: Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(views: bottomView, avatarImage)
//        bottomView.addSubviews(views: )
        setup()
        
    }
    
    //UI
    private lazy var bottomView: UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = .red
        bottomView.layer.cornerRadius = 20
        bottomView.clipsToBounds = true
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return bottomView
    }()
    
    private lazy var avatarImage: UIImageView = {
        let avatarImage = UIImageView()
        avatarImage.image = UIImage(named: "avatar")
        return avatarImage
    }()
    

    
    
    // Constraints
    private func setup() {
        bottomView.bottomToSuperview()
        bottomView.leadingToSuperview()
        bottomView.trailingToSuperview()
        bottomView.height(150)
        
        avatarImage.height(150)
        avatarImage.width(150)
        avatarImage.centerX(to: bottomView)
        avatarImage.bottomToTop(of: bottomView, offset: 60)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
