//
//  ProfileHeaderView.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 18.10.2022.
//

import UIKit
import TinyConstraints

protocol ProfileHeaderViewDelegate {
    func didTapOnPhotoStackView()
}

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    static let id = "ProfileHeaderView"
    var avatar: String?
    var heightForHeaderInSection: CGFloat?
    var delegate: ProfileHeaderViewDelegate?
    
    // MARK: Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = VCConstants.mainViewBackgroungColor
        contentView.addSubviews(views: bottomView, avatarImage, fullNameLabel, status, photoStackView)
        setup()
    }
    
    //MARK: UI
    private lazy var bottomView: UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = .white
        bottomView.layer.cornerRadius = VCConstants.bottomViewCornerRadius
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
        fullNameLabel.font = VCConstants.fullNameLabelFont
        fullNameLabel.textAlignment = .center
        return fullNameLabel
    }()
    
    lazy var status: UILabel = {
        let status = UILabel()
        status.font = VCConstants.statusLabelFont
        status.textAlignment = .center
        status.numberOfLines = 0
        return status
    }()
    
    private lazy var firstPhoto: WebImageView = {
        let firstPhoto = WebImageView()
        return firstPhoto
    }()
    
    private lazy var secondPhoto: WebImageView = {
        let secondPhoto = WebImageView()
        return secondPhoto
    }()
    
    private lazy var thirdPhoto: WebImageView = {
        let thirdPhoto = WebImageView()
        return thirdPhoto
    }()
    
    private lazy var fourthPhoto: WebImageView = {
        let fourthPhoto = WebImageView()
        return fourthPhoto
    }()
    
    private lazy var photoStackView: UIStackView = {
        let photoStackView = UIStackView()
        photoStackView.addArrangedSubview(firstPhoto)
        photoStackView.addArrangedSubview(secondPhoto)
        photoStackView.addArrangedSubview(thirdPhoto)
        photoStackView.addArrangedSubview(fourthPhoto)
        photoStackView.axis = .horizontal
        photoStackView.spacing = VCConstants.photoStackViewSpacing
        photoStackView.distribution = .fillEqually
        photoStackView.layer.cornerRadius = VCConstants.photoStackViewcornerRadius
        photoStackView.clipsToBounds = true
        return photoStackView
    }()
    
    //MARK: Setup
    
    func setupHeader(viewModel: UserInfoViewModel) {
        
        self.avatarImage.set(imageUrl: viewModel.photo200)
        let firstName = viewModel.firstName ?? ""
        let lastName = viewModel.lastName ?? ""
        self.fullNameLabel.text = firstName + " " + lastName
        let status = viewModel.status ?? ""
        self.status.text = status
        
        // Заполняем фотографии
        guard let photosArray = LocalStorage.shared.photosForHeader else { return }
        firstPhoto.set(imageUrl: photosArray[0])
        secondPhoto.set(imageUrl: photosArray[1])
        thirdPhoto.set(imageUrl: photosArray[2])
        fourthPhoto.set(imageUrl: photosArray[3])
        
        // Обработка нажатия на стэк фото
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapToPhoto))
        photoStackView.addGestureRecognizer(gesture)
    }
    
    @objc func tapToPhoto() {
        delegate?.didTapOnPhotoStackView()
    }
    
    // MARK: Constraints
    private func setup() {
        bottomView.topToSuperview(offset: VCConstants.bottomViewTopOffset)
        bottomView.bottomToSuperview()
        bottomView.leadingToSuperview()
        bottomView.trailingToSuperview()
        
        avatarImage.height(VCConstants.avatarImageHeight)
        avatarImage.width(VCConstants.avatarImageWidth)
        avatarImage.layer.cornerRadius = VCConstants.avatarImageCornerRadius
        avatarImage.clipsToBounds = true
        avatarImage.layer.borderWidth = VCConstants.avatarImageBorderWidth
        avatarImage.layer.borderColor = VCConstants.avatarImageBorderColor
        avatarImage.centerX(to: bottomView)
        avatarImage.bottomToTop(of: bottomView, offset: VCConstants.avatarImageBottomToTopOffset)

        fullNameLabel.topToBottom(of: avatarImage, offset: VCConstants.fullNameLabelTopOffset)
        fullNameLabel.leftToSuperview(offset: VCConstants.fullNameLabelLeftOffset)
        fullNameLabel.rightToSuperview(offset: VCConstants.fullNameLabelRightOffset)
        fullNameLabel.height(VCConstants.fullNameLabelHeight)

        status.topToBottom(of: fullNameLabel, offset: VCConstants.statusTopToBottomOffset)
        status.leftToSuperview(offset: VCConstants.statusLeftOffset)
        status.rightToSuperview(offset: VCConstants.statusRightOffset)
        status.height(VCConstants.statusHeight)
        
        photoStackView.topToBottom(of: status, offset: VCConstants.photoStackViewTopToBottomOffset)
        photoStackView.leftToSuperview(offset: VCConstants.photoStackViewLeftOffset)
        photoStackView.rightToSuperview(offset: VCConstants.photoStackViewRightOffset)
        photoStackView.height(VCConstants.photoStackViewHeight)
        photoStackView.bottomToSuperview(offset: VCConstants.photoStackViewBottomOffset)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
