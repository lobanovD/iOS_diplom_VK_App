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
    private var reposts: Int = 0
    private var views: Int = 0
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
        changeWidthRepostsView()
        changeWidthViewsView()
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
        repostsLabel.text = nil
        viewsLabel.text = nil
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
        likesView.layer.cornerRadius = CellConstants.buttonsViewLayerCornerRadius
        likesView.clipsToBounds = true
        return likesView
    }()
    
    private lazy var likesIcon: UIImageView = {
        let likesIcon = UIImageView()
        likesIcon.image = UIImage(named: CellConstants.buttonsLikesIconName)
        return likesIcon
    }()
    
    private lazy var likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.font = CellConstants.buttonsLabelFont
        likesLabel.textColor = UIColor(named: CellConstants.buttonsLabelTextColor)
        return likesLabel
    }()
    
    private lazy var commentsView: UIView = {
        let commentsView = UIView()
        commentsView.backgroundColor = .systemGray5
        commentsView.layer.cornerRadius = CellConstants.buttonsViewLayerCornerRadius
        commentsView.clipsToBounds = true
        return commentsView
    }()
    
    private lazy var commentsIcon: UIImageView = {
        let commentsIcon = UIImageView()
        commentsIcon.image = UIImage(named: CellConstants.buttonsCommentsIconName)
        return commentsIcon
    }()
    
    private lazy var commentsLabel: UILabel = {
        let commentsLabel = UILabel()
        commentsLabel.font = CellConstants.buttonsLabelFont
        commentsLabel.textColor = UIColor(named: CellConstants.buttonsLabelTextColor)
        return commentsLabel
    }()
    
    private lazy var repostsView: UIView = {
        let repostsView = UIView()
        repostsView.backgroundColor = .systemGray5
        repostsView.layer.cornerRadius = CellConstants.buttonsViewLayerCornerRadius
        repostsView.clipsToBounds = true
        return repostsView
    }()
    
    private lazy var repostsIcon: UIImageView = {
        let repostsIcon = UIImageView()
        repostsIcon.image = UIImage(named: CellConstants.buttonsRepostsIconName)
        return repostsIcon
    }()
    
    private lazy var repostsLabel: UILabel = {
        let repostsLabel = UILabel()
        repostsLabel.font = CellConstants.buttonsLabelFont
        repostsLabel.textColor = UIColor(named: CellConstants.buttonsLabelTextColor)
        return repostsLabel
    }()
    
    private lazy var viewsView: UIView = {
        let viewsView = UIView()
        viewsView.layer.cornerRadius = CellConstants.buttonsViewLayerCornerRadius
        viewsView.clipsToBounds = true
        return viewsView
    }()
    
    private lazy var viewsIcon: UIImageView = {
        let viewsIcon = UIImageView()
        viewsIcon.image = UIImage(named: CellConstants.buttonsViewsIconName)
        return viewsIcon
    }()
    
    private lazy var viewsLabel: UILabel = {
        let viewsLabel = UILabel()
        viewsLabel.font = CellConstants.buttonsLabelFont
        viewsLabel.textColor = UIColor(named: CellConstants.buttonsLabelTextColor)
        return viewsLabel
    }()
    
    
    
    // MARK: Constraints
    
    func setupViewsAndConstraints() {
        
        contentView.addSubviews(views: cardView)
        cardView.addSubviews(views: titleView, postText, postImageView, buttonViewBlock)
        titleView.addSubviews(views: titleIconImage, titleLabel, timeLabel)
        buttonViewBlock.addSubviews(views: likesView, commentsView, repostsView, viewsView)
        likesView.addSubviews(views: likesIcon, likesLabel)
        commentsView.addSubviews(views: commentsIcon, commentsLabel)
        repostsView.addSubviews(views: repostsIcon, repostsLabel)
        viewsView.addSubviews(views: viewsIcon, viewsLabel)
        
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
    
    // Метод нажатии на кнопку "Показать полностью"
    @objc func moreTextButtonTap() {
        print(1)
    }
    
    
    // Конфигурирование ячейки (наполнение данными)
    func setupCell(viewModel: FeedCellViewModel) {
        
        titleLabel.text = viewModel.name
        titleIconImage.set(imageUrl: viewModel.iconUrlString)
        timeLabel.text = viewModel.date
        
        postText.text = viewModel.text
        
    

        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        repostsLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        getLikesCount(viewModel: viewModel)
        getCommentsCount(viewModel: viewModel)
        getRepostCount(viewModel: viewModel)
        getViewsCount(viewModel: viewModel)
        
        changePhotoAttachmentHeight(viewModel: viewModel)
        
    }
    
    // MARK: Photo Attachment
    
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
    
    // MARK: View лайков
    
    // Метод, изменяющий переменную likes
    private func getLikesCount(viewModel: FeedCellViewModel) {
        guard let likes = Int(viewModel.likes ?? "0") else { return }
        self.likes = likes
    }
    
    // Метод, сбрасывающий и устанавливающий констрейнты для View с лайками
    private func likesViewConstraintsSetup(likesViewWidth: CGFloat) {
        likesView.constraints.deActivate()
        
        likesView.leadingToSuperview(offset: CellConstants.buttonsViewLeftOffset)
        likesView.topToSuperview(offset: CellConstants.buttonsViewTopOffset)
        likesView.bottomToSuperview(offset: CellConstants.buttonsViewBottomOffset)
        likesView.centerYToSuperview()
        likesView.width(likesViewWidth)
        
        likesIcon.leadingToSuperview(offset: CellConstants.buttonsIconLeftOffset)
        likesIcon.centerYToSuperview()
        likesIcon.width(CellConstants.buttonsIconWidth)
        likesIcon.height(CellConstants.buttonsIconHeight)
        
        likesLabel.leadingToTrailing(of: likesIcon, offset: CellConstants.buttonsLabelLeftOffset)
        likesLabel.centerYToSuperview()
    }
    
    // Метод, изменяющий ширину view в зависимости от кол-ва лайков
    private func changeWidthLikesView() {
        switch self.likes {
        case 0...9:
            likesViewConstraintsSetup(likesViewWidth: CellConstants.buttonsViewWidthForOneCountNumbers)
        case 10...99:
            likesViewConstraintsSetup(likesViewWidth: CellConstants.buttonsViewWidthForTwoCountNumbers)
        case 100...999:
            likesViewConstraintsSetup(likesViewWidth: CellConstants.buttonsViewWidthForThreeCountNumbers)
        case 1000...9999:
            likesViewConstraintsSetup(likesViewWidth: CellConstants.buttonsViewWidthForFourCountNumbers)
        default:
            break
        }
    }
    
    // MARK: View комментариев
    
    // Метод, изменяющий переменную comments
    private func getCommentsCount(viewModel: FeedCellViewModel) {
        guard let comments = Int(viewModel.comments ?? "0") else { return }
        self.comments = comments
    }
    
    // Метод, сбрасывающий и устанавливающий констрейнты для View с комментариями
    private func commentsViewConstraintsSetup(commentsViewWidth: CGFloat) {
        commentsView.constraints.deActivate()
        
        commentsView.leadingToTrailing(of: likesView, offset: CellConstants.buttonsViewLeftOffset)
        commentsView.topToSuperview(offset: CellConstants.buttonsViewTopOffset)
        commentsView.bottomToSuperview(offset: CellConstants.buttonsViewBottomOffset)
        commentsView.centerYToSuperview()
        commentsView.width(commentsViewWidth)
        
        commentsIcon.leadingToSuperview(offset: CellConstants.buttonsIconLeftOffset)
        commentsIcon.centerYToSuperview()
        commentsIcon.width(CellConstants.buttonsIconWidth)
        commentsIcon.height(CellConstants.buttonsIconHeight)
        
        commentsLabel.leadingToTrailing(of: commentsIcon, offset: CellConstants.buttonsLabelLeftOffset)
        commentsLabel.centerYToSuperview()
    }
    
    // Метод, изменяющий ширину view в зависимости от кол-ва комментариев
    private func changeWidthCommentsView() {
        switch self.comments {
        case 0...9:
            commentsViewConstraintsSetup(commentsViewWidth: CellConstants.buttonsViewWidthForOneCountNumbers)
        case 10...99:
            commentsViewConstraintsSetup(commentsViewWidth: CellConstants.buttonsViewWidthForTwoCountNumbers)
        case 100...999:
            commentsViewConstraintsSetup(commentsViewWidth: CellConstants.buttonsViewWidthForThreeCountNumbers)
        case 1000...9999:
            commentsViewConstraintsSetup(commentsViewWidth: CellConstants.buttonsViewWidthForFourCountNumbers)
        case 10000...99999:
            commentsViewConstraintsSetup(commentsViewWidth: CellConstants.buttonsViewWidthForFiveCountNumbers)
        case 100000...999999:
            commentsViewConstraintsSetup(commentsViewWidth: CellConstants.buttonsViewWidthForSixCountNumbers)
        default:
            break
        }
    }
    
    
    // MARK: View репостов
    
    // Метод, изменяющий переменную reposts
    private func getRepostCount(viewModel: FeedCellViewModel) {
        guard let reposts = Int(viewModel.shares ?? "0") else { return }
        self.reposts = reposts
    }
    
    // Метод, сбрасывающий и устанавливающий констрейнты для View с репостами
    private func repostsViewConstraintsSetup(repostsViewWidth: CGFloat) {
        repostsView.constraints.deActivate()
        
        repostsView.leadingToTrailing(of: commentsView, offset: CellConstants.buttonsViewLeftOffset)
        repostsView.topToSuperview(offset: CellConstants.buttonsViewTopOffset)
        repostsView.bottomToSuperview(offset: CellConstants.buttonsViewBottomOffset)
        repostsView.centerYToSuperview()
        repostsView.width(repostsViewWidth)
        
        repostsIcon.leadingToSuperview(offset: CellConstants.buttonsIconLeftOffset)
        repostsIcon.centerYToSuperview()
        repostsIcon.width(CellConstants.buttonsIconWidth)
        repostsIcon.height(CellConstants.buttonsIconHeight)
        
        repostsLabel.leadingToTrailing(of: repostsIcon, offset: CellConstants.buttonsLabelLeftOffset)
        repostsLabel.centerYToSuperview()
    }
    
    // Метод, изменяющий ширину view в зависимости от кол-ва репостов
    private func changeWidthRepostsView() {
        switch self.reposts {
        case 0...9:
            repostsViewConstraintsSetup(repostsViewWidth: CellConstants.buttonsViewWidthForOneCountNumbers)
        case 10...99:
            repostsViewConstraintsSetup(repostsViewWidth: CellConstants.buttonsViewWidthForTwoCountNumbers)
        case 100...999:
            repostsViewConstraintsSetup(repostsViewWidth: CellConstants.buttonsViewWidthForThreeCountNumbers)
        case 1000...9999:
            repostsViewConstraintsSetup(repostsViewWidth: CellConstants.buttonsViewWidthForFourCountNumbers)
        case 10000...99999:
            repostsViewConstraintsSetup(repostsViewWidth: CellConstants.buttonsViewWidthForFiveCountNumbers)
        case 100000...999999:
            repostsViewConstraintsSetup(repostsViewWidth: CellConstants.buttonsViewWidthForSixCountNumbers)
        default:
            break
        }
    }
    
    
    // MARK: View просмотров
    
    // Метод, изменяющий переменную views
    private func getViewsCount(viewModel: FeedCellViewModel) {
        guard let views = Int(viewModel.views ?? "0") else { return }
        self.views = views
    }
    
    // Метод, сбрасывающий и устанавливающий констрейнты для View с просмотрами
    private func viewsViewConstraintsSetup(viewsViewWidth: CGFloat) {
        viewsView.constraints.deActivate()
        
        viewsView.trailing(to: buttonViewBlock, offset: CellConstants.buttonsViewRightOffset)
        viewsView.topToSuperview(offset: CellConstants.buttonsViewTopOffset)
        viewsView.bottomToSuperview(offset: CellConstants.buttonsViewBottomOffset)
        viewsView.centerYToSuperview()
        viewsView.width(viewsViewWidth)
        
        viewsIcon.trailingToLeading(of: viewsLabel)
        viewsIcon.centerYToSuperview()
        viewsIcon.width(CellConstants.buttonsIconWidth)
        viewsIcon.height(CellConstants.buttonsIconHeight)
        
        viewsLabel.trailing(to: viewsView, offset: CellConstants.buttonsViewRightOffset)
        viewsLabel.centerYToSuperview()
    }
    
    // Метод, изменяющий ширину view в зависимости от кол-ва просмотров
    private func changeWidthViewsView() {
        switch self.views {
        case 0...9:
            viewsViewConstraintsSetup(viewsViewWidth: CellConstants.buttonsViewWidthForOneCountNumbers)
        case 10...99:
            viewsViewConstraintsSetup(viewsViewWidth: CellConstants.buttonsViewWidthForTwoCountNumbers)
        case 100...999:
            viewsViewConstraintsSetup(viewsViewWidth: CellConstants.buttonsViewWidthForThreeCountNumbers)
        case 1000...9999:
            viewsViewConstraintsSetup(viewsViewWidth: CellConstants.buttonsViewWidthForFourCountNumbers)
        case 10000...99999:
            viewsViewConstraintsSetup(viewsViewWidth: CellConstants.buttonsViewWidthForFiveCountNumbers)
        case 100000...999999:
            viewsViewConstraintsSetup(viewsViewWidth: CellConstants.buttonsViewWidthForSixCountNumbers)
        default:
            break
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
