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
    var heightForHeaderInSection: CGFloat?
    
    // MARK: Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(views: bottomView, avatarImage, fullNameLabel, status, photoStackView)

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
    
    
    private lazy var avatarImage: WebImageView = {
        let avatarImage = WebImageView()
        return avatarImage
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        fullNameLabel.textAlignment = .center
        return fullNameLabel
    }()
    
    lazy var status: UILabel = {
        let status = UILabel()
        status.font = UIFont.systemFont(ofSize: 18, weight: .light)
        status.textAlignment = .center
        status.numberOfLines = 0
        return status
    }()
    
    private lazy var firstPhoto: WebImageView = {
        let firstPhoto = WebImageView()
        firstPhoto.set(imageUrl: "https://sun9-78.userapi.com/impg/H3khl6YFEG0RkETKuw4ITGSXLIzPG4py9N19sQ/I74YCNNeKnY.jpg?size=320x427&quality=95&sign=513da1cf89ce83c8751e446798ee4d83&c_uniq_tag=ijfOb7niZ-3aSDQECbQIqsWdPFcq9GVrqDjb7B8tbf8&type=album")
        return firstPhoto
    }()
    
    private lazy var secondPhoto: WebImageView = {
        let secondPhoto = WebImageView()
        secondPhoto.set(imageUrl: "https://sun9-3.userapi.com/impg/LsdcRqt7UDjIdK5bDFUlh2HwnWRDYz3HPtQ8Lg/j_T6OSK94J4.jpg?size=56x75&quality=95&sign=1ecc12e9167c421171225f00a608c99a&c_uniq_tag=GuOcWu6jp-Y-HVSuuD_SsU8H_GbUeKGwhshOdSH9wQs&type=album")
        return secondPhoto
    }()
    
    private lazy var thirdPhoto: WebImageView = {
        let thirdPhoto = WebImageView()
        thirdPhoto.set(imageUrl: "https://sun9-3.userapi.com/impg/LsdcRqt7UDjIdK5bDFUlh2HwnWRDYz3HPtQ8Lg/j_T6OSK94J4.jpg?size=56x75&quality=95&sign=1ecc12e9167c421171225f00a608c99a&c_uniq_tag=GuOcWu6jp-Y-HVSuuD_SsU8H_GbUeKGwhshOdSH9wQs&type=album")
        return thirdPhoto
    }()
    
    private lazy var fourthPhoto: WebImageView = {
        let fourthPhoto = WebImageView()
        fourthPhoto.set(imageUrl: "https://sun9-3.userapi.com/impg/LsdcRqt7UDjIdK5bDFUlh2HwnWRDYz3HPtQ8Lg/j_T6OSK94J4.jpg?size=56x75&quality=95&sign=1ecc12e9167c421171225f00a608c99a&c_uniq_tag=GuOcWu6jp-Y-HVSuuD_SsU8H_GbUeKGwhshOdSH9wQs&type=album")
        return fourthPhoto
    }()
    
    private lazy var photoStackView: UIStackView = {
        let photoStackView = UIStackView()
        photoStackView.addArrangedSubview(firstPhoto)
        photoStackView.addArrangedSubview(secondPhoto)
        photoStackView.addArrangedSubview(thirdPhoto)
        photoStackView.addArrangedSubview(fourthPhoto)
        photoStackView.axis = .horizontal
        photoStackView.spacing = 6
        photoStackView.distribution = .fillEqually
        photoStackView.layer.cornerRadius = 10
        photoStackView.clipsToBounds = true
        return photoStackView
    }()
    
    func setupHeader(viewModel: UserInfoViewModel) {
        
        self.avatarImage.set(imageUrl: viewModel.photo200)
        let firstName = viewModel.firstName ?? ""
        let lastName = viewModel.lastName ?? ""
        self.fullNameLabel.text = firstName + " " + lastName
        let status = viewModel.status ?? ""
        self.status.text = status
        
//        if self.status.countLines() == 3 {
//            self.heightForHeaderInSection = 700
//        }
    }
    
    
    
    
    // Constraints
    private func setup() {
        bottomView.topToSuperview(offset: 100)
        bottomView.bottomToSuperview()
        bottomView.leadingToSuperview()
        bottomView.trailingToSuperview()
        bottomView.height(150)
        
        avatarImage.height(150)
        avatarImage.width(150)
        avatarImage.layer.cornerRadius = 75
        avatarImage.clipsToBounds = true
        avatarImage.layer.borderWidth = 2
        avatarImage.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        avatarImage.centerX(to: bottomView)
        avatarImage.bottomToTop(of: bottomView, offset: 60)

        fullNameLabel.topToBottom(of: avatarImage, offset: 10)
        fullNameLabel.leftToSuperview(offset: 6)
        fullNameLabel.rightToSuperview(offset: -6)

        status.topToBottom(of: fullNameLabel, offset: 3)
        status.leftToSuperview(offset: 6)
        status.rightToSuperview(offset: -6)
        status.height(60) // ВОТ ТУТ СДЕЛАТЬ ВЫЧИСЛЕНИЕ ВЫСОТЫ

        photoStackView.topToBottom(of: status, offset: 6)
        photoStackView.leftToSuperview(offset: 6)
        photoStackView.rightToSuperview(offset: -6)
        photoStackView.height(100)
        photoStackView.bottomToSuperview(offset: -10)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
