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
    private var photoAttachmentHeight: CGFloat = 0
    
    // Инициализация ячейки
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewsAndConstraints()
    }
    
    // Обновление subviews
    override func layoutSubviews() {
        changeWidthLikesView()
        photoAttachmentConstraintsSetup()
    }
    
    // Убираем данные ячейки перед переиспользованием
    override func prepareForReuse() {
        iconImage.set(imageUrl: nil)
        iconImage.set(imageUrl: nil)
        titleLable.text = nil
        timeLable.text = nil
        postText.text = nil
        postImageView.set(imageUrl: nil)
        likesLabel.text = nil
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
    
    // View заголовка (содержит иконку, название/имя пользователя и время поста)
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
    
    // Кнопки
    private lazy var buttonView: UIView = {
        let buttonView = UIView()
        //buttonView.backgroundColor = .green
        return buttonView
    }()
    
    private lazy var likesView: UIView = {
        let likesView = UIView()
        likesView.backgroundColor = .systemGray5
        likesView.layer.cornerRadius = 15
        likesView.clipsToBounds = true
        return likesView
    }()
    
    private lazy var likesImage: UIImageView = {
        let likesImage = UIImageView()
        likesImage.image = UIImage(named: "like")
        return likesImage
    }()
    
    private lazy var likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.font = UIFont.systemFont(ofSize: 14)
        likesLabel.textColor = UIColor(named: "likesColor")
        return likesLabel
    }()
    
    // MARK: Constraints
    
    func setupViewsAndConstraints() {
        
        contentView.addSubviews(views: cardView)
        cardView.addSubviews(views: titleView, postText, postImageView, buttonView)
        titleView.addSubviews(views: iconImage, titleLable, timeLable)
        buttonView.addSubviews(views: likesView)
        likesView.addSubviews(views: likesImage, likesLabel)
        
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
        
        photoAttachmentConstraintsSetup()
        
        buttonView.leadingToSuperview()
        buttonView.trailingToSuperview()
        buttonView.bottomToSuperview()
        buttonView.height(CellConstants.buttonViewHeight)
        
        likesViewConstraintsSetup(likesViewWidth: 0)
        
    }
    
    
    
    // Конфигурирование ячейки (наполнение данными)
    func setupCell(viewModel: FeedCellViewModel) {
        
        titleLable.text = viewModel.name
        iconImage.set(imageUrl: viewModel.iconUrlString)
        timeLable.text = viewModel.date
        postText.text = viewModel.text
        likesLabel.text = viewModel.likes
        
        getLikesCount(viewModel: viewModel)
        
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
//            postImageView.height(cellHeight)
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
    

    
    
    // MARK: Работа с ячейкой лайков
    
    // Метод, изменяющий переменную likes
    private func getLikesCount(viewModel: FeedCellViewModel) {
        guard let likes = Int(viewModel.likes ?? "0") else { return }
        self.likes = likes
    }
    
    // Метод, сбрасывающий и устанавливающий констрейнты для View с лайками
    private func likesViewConstraintsSetup(likesViewWidth: CGFloat) {
        likesView.constraints.deActivate()
        
        likesView.leadingToSuperview(offset: 8)
        likesView.topToSuperview(offset: 6)
        likesView.bottomToSuperview(offset: -6)
        likesView.centerYToSuperview()
        likesView.width(likesViewWidth)
        
        likesImage.leadingToSuperview(offset: 8)
        likesImage.centerYToSuperview()
        likesImage.width(20)
        likesImage.height(20)
        
        likesLabel.leadingToTrailing(of: likesImage, offset: 6)
        likesLabel.centerYToSuperview()
    }
    
    // Метод, изменяющий ширину view в зависимости от кол-ва лайков
    private func changeWidthLikesView() {
        switch self.likes {
        case 0...9:
            likesViewConstraintsSetup(likesViewWidth: 55)
        case 10...99:
            likesViewConstraintsSetup(likesViewWidth: 65)
        case 100...999:
            likesViewConstraintsSetup(likesViewWidth: 75)
        case 1000...9999:
            likesViewConstraintsSetup(likesViewWidth: 85)
        default:
            break
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
