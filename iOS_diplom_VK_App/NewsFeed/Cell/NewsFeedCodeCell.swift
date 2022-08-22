//
//  NewsFeedCodeCell.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 20.08.2022.
//

import Foundation
import UIKit
import TinyConstraints

protocol FeedCellViewModel {
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes:String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var photoAttachment: FeedCellPhotoAttachmentViewModel? { get }
    
    var totalHeight: CGFloat { get }
    
}


protocol FeedCellPhotoAttachmentViewModel {
    var photoUrlString: String? { get }
    var width: Int { get set}
    var height: Int { get set}
}

final class NewsFeedCodeCell: UITableViewCell {
    
    static let id = "NewsFeedCodeCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)

        contentView.addSubviews(views: cardView)
        cardView.addSubviews(views: titleView, postText, postImageView)
        titleView.addSubviews(views: iconImage, titleLable, timeLable)
        setupConstraints()

    }
    
    // убираем URL старой картинки перед переиспользованием
    override func prepareForReuse() {
        iconImage.set(imageUrl: nil)
        iconImage.set(imageUrl: nil)
    }
     
    
    // MARK: UI
    
    // Основное View поста
    private lazy var cardView: UIView = {
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        return cardView
    }()
    
    // View заголовка (содержит иконку, название/имя пользователя и время поста
    private lazy var titleView: UIView = {
        let titleView = UIView()
        titleView.backgroundColor = .red
        return titleView
    }()
    
    // Иконка группы/пользователя
    private lazy var iconImage: WebImageView = {
        let iconImage = WebImageView()
        iconImage.layer.cornerRadius = 20
        iconImage.clipsToBounds = true
        return iconImage
    }()
    
    // Название группы/имя пользователя
    private lazy var titleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.text = "РИА Новости"
        titleLable.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return titleLable
    }()
    
    // Время поста
    private lazy var timeLable: UILabel = {
        let timeLable = UILabel()
        timeLable.text = "20 авг. в 16:04"
        timeLable.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return timeLable
    }()
    
    // Текст поста
    private lazy var postText: UILabel = {
        let postText = UILabel()
        postText.font = CellConstants.postTextFontSize
        postText.numberOfLines = 0
        return postText
    }()
    
    // Приложения поста (фото)
    private lazy var postImageView: WebImageView = {
        let postImageView = WebImageView()
        return postImageView
    }()
    
    
    // MARK: Constraints
    
    func setupConstraints() {
        
        cardView.topToSuperview(offset: CellConstants.cardViewTopOffset)
        cardView.leadingToSuperview(offset: CellConstants.cardViewLeftOffset)
        cardView.trailingToSuperview(offset: CellConstants.cardViewRightOffset)
        cardView.bottomToSuperview(offset: CellConstants.cardViewBottomOffset)
        
        titleView.topToSuperview(offset: CellConstants.titleViewTopOffset)
        titleView.trailingToSuperview(offset: CellConstants.titleViewRightOffset)
        titleView.leadingToSuperview(offset: CellConstants.titleViewLeftOffset)
        titleView.height(CellConstants.titleViewHeight)
        
        iconImage.centerYToSuperview()
        iconImage.leadingToSuperview(offset: 6)
        iconImage.height(40)
        iconImage.width(40)

        titleLable.topToSuperview(offset: 6)
        titleLable.leadingToTrailing(of: iconImage, offset: 6)
        
        timeLable.bottomToSuperview(offset: -6)
        timeLable.leadingToTrailing(of: iconImage, offset: 6)
        
        postText.topToBottom(of: titleView, offset: CellConstants.postTextTopOffset)
        postText.leadingToSuperview(offset: CellConstants.postTextLeftOffset)
        postText.trailingToSuperview(offset:CellConstants.postTextRightOffset)
        
        postImageView.topToBottom(of: postText, offset: CellConstants.postImageViewTopOffset)
        postImageView.width(to: cardView)
    }
    
    func setupCell(viewModel: FeedCellViewModel) {
        titleLable.text = viewModel.name
        iconImage.set(imageUrl: viewModel.iconUrlString)
        timeLable.text = viewModel.date
        postText.text = viewModel.text
        
        if let photoAttachment = viewModel.photoAttachment {
            postImageView.set(imageUrl: photoAttachment.photoUrlString)
            postImageView.isHidden = false
            let heightCalculator = CalculateCellHeight()
            let cellHeight = heightCalculator.calculatePhotoAttachmentHeight(photoAttachment: photoAttachment)
            postImageView.height(cellHeight)
            
            
        } else {
            postImageView.isHidden = true
        }
        
    }
    

    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



