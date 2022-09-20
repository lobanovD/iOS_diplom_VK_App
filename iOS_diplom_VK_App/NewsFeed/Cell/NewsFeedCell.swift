//
//  NewsFeedCell.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 20.08.2022.
//

import Foundation
import UIKit
import TinyConstraints

final class NewsFeedCell: UITableViewCell {
    
    // Переменные и константы
    static let id = "NewsFeedCodeCell"
    private var likes: Int = 0
    private var comments: Int = 0
    private var photoAttachmentHeight: CGFloat = 0
    
    // Инициализация ячейки
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewsAndConstraints()
    }
    
    // Обновление subviews
    override func layoutSubviews() {
        changeWidthLikesView()
        changeWidthCommentsView()
        photoAttachmentConstraintsSetup()
    }
    
    // Убираем данные ячейки перед переиспользованием
    override func prepareForReuse() {
        titleIconImage.set(imageUrl: nil)
        titleIconImage.set(imageUrl: nil)
        titleLabel.text = nil
        timeLabel.text = nil
        postText.text = nil
        postImageView.set(imageUrl: nil)
        likesLabel.text = nil
        commentsLabel.text = nil
    }
    
    // MARK: UI
    
    // Основное View поста
    private lazy var cardView: UIView = {
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = CellConstants.cardViewLayerCornerRadius
        cardView.clipsToBounds = true
        return cardView
    }()
    
    // View заголовка (содержит иконку, название/имя пользователя и время поста)
    private lazy var titleView: UIView = {
        let titleView = UIView()
        return titleView
    }()
    
    // Иконка группы/пользователя
    private lazy var titleIconImage: WebImageView = {
        let titleIconImage = WebImageView()
        titleIconImage.layer.cornerRadius = CellConstants.titleImageLayerCornerRadius
        titleIconImage.clipsToBounds = true
        return titleIconImage
    }()
    
    // Название группы/имя пользователя
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = CellConstants.titleLabelFont
        return titleLabel
    }()
    
    // Время поста
    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = CellConstants.timeLabelFont
        return timeLabel
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
    
    // Кнопки
    private lazy var buttonViewBlock: UIView = {
        let buttonViewBlock = UIView()
        return buttonViewBlock
    }()
    
    private lazy var likesView: UIView = {
        let likesView = UIView()
        likesView.backgroundColor = .systemGray5
        likesView.layer.cornerRadius = CellConstants.likesViewLayerCornerRadius
        likesView.clipsToBounds = true
        return likesView
    }()
    
    private lazy var likesIcon: UIImageView = {
        let likesIcon = UIImageView()
        likesIcon.image = UIImage(named: CellConstants.likesIconName)
        return likesIcon
    }()
    
    private lazy var likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.font = CellConstants.likesLabelFont
        likesLabel.textColor = UIColor(named: CellConstants.likesLabelTextColor)
        return likesLabel
    }()
    
    private lazy var commentsView: UIView = {
        let commentsView = UIView()
        commentsView.backgroundColor = .systemGray5
        commentsView.layer.cornerRadius = CellConstants.commentsViewLayerCornerRadius
        commentsView.clipsToBounds = true
        return commentsView
    }()
    
    private lazy var commentsIcon: UIImageView = {
        let commentsIcon = UIImageView()
        commentsIcon.image = UIImage(named: CellConstants.commentsIconName)
        return commentsIcon
    }()
    
    private lazy var commentsLabel: UILabel = {
        let commentsLabel = UILabel()
        commentsLabel.font = CellConstants.commentsLabelFont
        commentsLabel.textColor = UIColor(named: CellConstants.commentsLabelTextColor)
        return commentsLabel
    }()
    
    // MARK: Constraints
    
    func setupViewsAndConstraints() {
        
        contentView.addSubviews(views: cardView)
        cardView.addSubviews(views: titleView, postText, postImageView, buttonViewBlock)
        titleView.addSubviews(views: titleIconImage, titleLabel, timeLabel)
        buttonViewBlock.addSubviews(views: likesView, commentsView)
        likesView.addSubviews(views: likesIcon, likesLabel)
        commentsView.addSubviews(views: commentsIcon, commentsLabel)
        
        cardView.topToSuperview(offset: CellConstants.cardViewTopOffset)
        cardView.leadingToSuperview(offset: CellConstants.cardViewLeftOffset)
        cardView.trailingToSuperview(offset: CellConstants.cardViewRightOffset)
        cardView.bottomToSuperview(offset: CellConstants.cardViewBottomOffset)
        
        titleView.topToSuperview(offset: CellConstants.titleViewTopOffset)
        titleView.trailingToSuperview(offset: CellConstants.titleViewRightOffset)
        titleView.leadingToSuperview(offset: CellConstants.titleViewLeftOffset)
        titleView.height(CellConstants.titleViewHeight)
        
        titleIconImage.centerYToSuperview()
        titleIconImage.leadingToSuperview()
        titleIconImage.height(CellConstants.titleIconImageHeight)
        titleIconImage.width(CellConstants.titleIconImageWidth)
        
        titleLabel.topToSuperview(offset: CellConstants.titleLabelTopOffset)
        titleLabel.leadingToTrailing(of: titleIconImage, offset: CellConstants.titleLabelLeftOffset)
        
        timeLabel.bottomToSuperview(offset: CellConstants.timeLabelBottomOffset)
        timeLabel.leadingToTrailing(of: titleIconImage, offset: CellConstants.timeLabelRightOffset)
        
        postText.topToBottom(of: titleView, offset: CellConstants.postTextTopOffset)
        postText.leadingToSuperview(offset: CellConstants.postTextLeftOffset)
        postText.trailingToSuperview(offset:CellConstants.postTextRightOffset)
        
        photoAttachmentConstraintsSetup()
        
        buttonViewBlock.leadingToSuperview()
        buttonViewBlock.trailingToSuperview()
        buttonViewBlock.bottomToSuperview()
        buttonViewBlock.height(CellConstants.buttonViewHeight)
         
    }
    
    // Конфигурирование ячейки (наполнение данными)
    func setupCell(viewModel: FeedCellViewModel) {
        
        titleLabel.text = viewModel.name
        titleIconImage.set(imageUrl: viewModel.iconUrlString)
        timeLabel.text = viewModel.date
        postText.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        
        getLikesCount(viewModel: viewModel)
        getCommentsCount(viewModel: viewModel)
        
        changePhotoAttachmentHeight(viewModel: viewModel)
        
    }
    
    // MARK: Работа с Photo Attachment
    
    // Метод, изменяющий размер полученного фото
    private func changePhotoAttachmentHeight(viewModel: FeedCellViewModel) {
        if let photoAttachment = viewModel.photoAttachment {
            postImageView.set(imageUrl: photoAttachment.photoUrlString)
            postImageView.isHidden = false
            let heightCalculator = CalculateCellHeight()
            let cellHeight = heightCalculator.calculatePhotoAttachmentHeight(photoAttachment: photoAttachment)
            self.photoAttachmentHeight = cellHeight
        } else {
            postImageView.isHidden = true
        }
    }
    
    // Метод, сбрасывающий и устанавливающий констрейнты для Photo Attachment
    private func photoAttachmentConstraintsSetup() {
        postImageView.constraints.deActivate()
        postImageView.topToBottom(of: postText, offset: CellConstants.postImageViewTopOffset)
        postImageView.width(to: cardView)
        postImageView.height(self.photoAttachmentHeight)
    }
    
    // MARK: Работа с View лайков
    
    // Метод, изменяющий переменную likes
    private func getLikesCount(viewModel: FeedCellViewModel) {
        guard let likes = Int(viewModel.likes ?? "0") else { return }
        self.likes = likes
    }
    
    // Метод, сбрасывающий и устанавливающий констрейнты для View с лайками
    private func likesViewConstraintsSetup(likesViewWidth: CGFloat) {
        likesView.constraints.deActivate()
        
        likesView.leadingToSuperview(offset: CellConstants.likesViewLeftOffset)
        likesView.topToSuperview(offset: CellConstants.likesViewTopOffset)
        likesView.bottomToSuperview(offset: CellConstants.likesViewBottomOffset)
        likesView.centerYToSuperview()
        likesView.width(likesViewWidth)
        
        likesIcon.leadingToSuperview(offset: CellConstants.likesIconLeftOffset)
        likesIcon.centerYToSuperview()
        likesIcon.width(CellConstants.likesIconWidth)
        likesIcon.height(CellConstants.likesIconHeight)
        
        likesLabel.leadingToTrailing(of: likesIcon, offset: CellConstants.likesLabelLeftOffset)
        likesLabel.centerYToSuperview()
    }
    
    // Метод, изменяющий ширину view в зависимости от кол-ва лайков
    private func changeWidthLikesView() {
        switch self.likes {
        case 0...9:
            likesViewConstraintsSetup(likesViewWidth: CellConstants.likesViewWidthForOneCountNumbers)
        case 10...99:
            likesViewConstraintsSetup(likesViewWidth: CellConstants.likesViewWidthForTwoCountNumbers)
        case 100...999:
            likesViewConstraintsSetup(likesViewWidth: CellConstants.likesViewWidthForThreeCountNumbers)
        case 1000...9999:
            likesViewConstraintsSetup(likesViewWidth: CellConstants.likesViewWidthForFourCountNumbers)
        default:
            break
        }
    }
    
    // MARK: Работа с View комментариев
    
    // Метод, изменяющий переменную comments
    private func getCommentsCount(viewModel: FeedCellViewModel) {
        guard let comments = Int(viewModel.comments ?? "0") else { return }
        self.comments = comments
    }
    
    // Метод, сбрасывающий и устанавливающий констрейнты для View с комментариями
    private func commentsViewConstraintsSetup(commentsViewWidth: CGFloat) {
        commentsView.constraints.deActivate()
        
        commentsView.leadingToTrailing(of: likesView, offset: CellConstants.commentsViewLeftOffset)
        commentsView.topToSuperview(offset: CellConstants.commentsViewTopOffset)
        commentsView.bottomToSuperview(offset: CellConstants.commentsViewBottomOffset)
        commentsView.centerYToSuperview()
        commentsView.width(commentsViewWidth)
        
        commentsIcon.leadingToSuperview(offset: CellConstants.commentsIconLeftOffset)
        commentsIcon.centerYToSuperview()
        commentsIcon.width(CellConstants.commentsIconWidth)
        commentsIcon.height(CellConstants.commentsIconHeight)
        
        commentsLabel.leadingToTrailing(of: commentsIcon, offset: CellConstants.commentsLabelLeftOffset)
        commentsLabel.centerYToSuperview()
    }
    
    // Метод, изменяющий ширину view в зависимости от кол-ва комментариев
    private func changeWidthCommentsView() {
        switch self.comments {
        case 0...9:
            commentsViewConstraintsSetup(commentsViewWidth: CellConstants.commentsViewWidthForOneCountNumbers)
        case 10...99:
            commentsViewConstraintsSetup(commentsViewWidth: CellConstants.commentsViewWidthForTwoCountNumbers)
        case 100...999:
            commentsViewConstraintsSetup(commentsViewWidth: CellConstants.commentsViewWidthForThreeCountNumbers)
        case 1000...9999:
            commentsViewConstraintsSetup(commentsViewWidth: CellConstants.commentsViewWidthForFourCountNumbers)
        default:
            break
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
