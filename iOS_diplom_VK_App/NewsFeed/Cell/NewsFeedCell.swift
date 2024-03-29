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
    
    @objc var tapLike : (()->())?
    
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
        likesIcon.image = nil
        commentsLabel.text = nil
        repostsLabel.text = nil
        viewsLabel.text = nil
        
    }
    
    // MARK: UI
    
    // Основное View поста
    private lazy var cardView: UIView = {
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = FeedVCConstants.cardViewLayerCornerRadius
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
        titleIconImage.layer.cornerRadius = FeedVCConstants.titleImageLayerCornerRadius
        titleIconImage.clipsToBounds = true
        return titleIconImage
    }()
    
    // Название группы/имя пользователя
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = FeedVCConstants.titleLabelFont
        return titleLabel
    }()
    
    // Время поста
    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = FeedVCConstants.timeLabelFont
        return timeLabel
    }()
    
    // Текст поста
    private lazy var postText: UILabel = {
        let postText = UILabel()
        postText.font = FeedVCConstants.postTextFontSize
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
        likesView.layer.cornerRadius = FeedVCConstants.buttonsViewLayerCornerRadius
        likesView.clipsToBounds = true
        return likesView
    }()
    
    private  lazy var likeActionButton: UIButton = {
        let likeActionButton = UIButton()
        likeActionButton.layer.cornerRadius = FeedVCConstants.buttonsViewLayerCornerRadius
        likeActionButton.clipsToBounds = true
        return likeActionButton
    }()
    
    private lazy var likesIcon: UIImageView = {
        let likesIcon = UIImageView()
        return likesIcon
    }()
    
    private lazy var likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.font = FeedVCConstants.buttonsLabelFont
        likesLabel.textColor = UIColor(named: FeedVCConstants.buttonsLabelTextColor)
        return likesLabel
    }()
    
    private lazy var commentsView: UIView = {
        let commentsView = UIView()
        commentsView.backgroundColor = .systemGray5
        commentsView.layer.cornerRadius = FeedVCConstants.buttonsViewLayerCornerRadius
        commentsView.clipsToBounds = true
        return commentsView
    }()
    
    private lazy var commentsIcon: UIImageView = {
        let commentsIcon = UIImageView()
        commentsIcon.image = UIImage(named: FeedVCConstants.buttonsCommentsIconName)
        return commentsIcon
    }()
    
    private lazy var commentsLabel: UILabel = {
        let commentsLabel = UILabel()
        commentsLabel.font = FeedVCConstants.buttonsLabelFont
        commentsLabel.textColor = UIColor(named: FeedVCConstants.buttonsLabelTextColor)
        return commentsLabel
    }()
    
    private lazy var repostsView: UIView = {
        let repostsView = UIView()
        repostsView.backgroundColor = .systemGray5
        repostsView.layer.cornerRadius = FeedVCConstants.buttonsViewLayerCornerRadius
        repostsView.clipsToBounds = true
        return repostsView
    }()
    
    private lazy var repostsIcon: UIImageView = {
        let repostsIcon = UIImageView()
        repostsIcon.image = UIImage(named: FeedVCConstants.buttonsRepostsIconName)
        return repostsIcon
    }()
    
    private lazy var repostsLabel: UILabel = {
        let repostsLabel = UILabel()
        repostsLabel.font = FeedVCConstants.buttonsLabelFont
        repostsLabel.textColor = UIColor(named: FeedVCConstants.buttonsLabelTextColor)
        return repostsLabel
    }()
    
    private lazy var viewsView: UIView = {
        let viewsView = UIView()
        viewsView.layer.cornerRadius = FeedVCConstants.buttonsViewLayerCornerRadius
        viewsView.clipsToBounds = true
        return viewsView
    }()
    
    private lazy var viewsIcon: UIImageView = {
        let viewsIcon = UIImageView()
        viewsIcon.image = UIImage(named: FeedVCConstants.buttonsViewsIconName)
        return viewsIcon
    }()
    
    private lazy var viewsLabel: UILabel = {
        let viewsLabel = UILabel()
        viewsLabel.font = FeedVCConstants.buttonsLabelFont
        viewsLabel.textColor = UIColor(named: FeedVCConstants.buttonsLabelTextColor)
        return viewsLabel
    }()
    
    // MARK: Constraints
    func setupViewsAndConstraints() {
        
        contentView.addSubviews(views: cardView)
        cardView.addSubviews(views: titleView, postText, postImageView, buttonViewBlock)
        titleView.addSubviews(views: titleIconImage, titleLabel, timeLabel)
        buttonViewBlock.addSubviews(views: likesView, commentsView, repostsView, viewsView)
        likesView.addSubviews(views: likesIcon, likesLabel, likeActionButton)
        commentsView.addSubviews(views: commentsIcon, commentsLabel)
        repostsView.addSubviews(views: repostsIcon, repostsLabel)
        viewsView.addSubviews(views: viewsIcon, viewsLabel)
        
        cardView.topToSuperview(offset: FeedVCConstants.cardViewTopOffset)
        cardView.leadingToSuperview(offset: FeedVCConstants.cardViewLeftOffset)
        cardView.trailingToSuperview(offset: FeedVCConstants.cardViewRightOffset)
        cardView.bottomToSuperview(offset: FeedVCConstants.cardViewBottomOffset)
        
        titleView.topToSuperview(offset: FeedVCConstants.titleViewTopOffset)
        titleView.trailingToSuperview(offset: FeedVCConstants.titleViewRightOffset)
        titleView.leadingToSuperview(offset: FeedVCConstants.titleViewLeftOffset)
        titleView.height(FeedVCConstants.titleViewHeight)
        
        titleIconImage.centerYToSuperview()
        titleIconImage.leadingToSuperview()
        titleIconImage.height(FeedVCConstants.titleIconImageHeight)
        titleIconImage.width(FeedVCConstants.titleIconImageWidth)
        
        titleLabel.topToSuperview(offset: FeedVCConstants.titleLabelTopOffset)
        titleLabel.leadingToTrailing(of: titleIconImage, offset: FeedVCConstants.titleLabelLeftOffset)
        
        timeLabel.bottomToSuperview(offset: FeedVCConstants.timeLabelBottomOffset)
        timeLabel.leadingToTrailing(of: titleIconImage, offset: FeedVCConstants.timeLabelRightOffset)
        
        postText.topToBottom(of: titleView, offset: FeedVCConstants.postTextTopOffset)
        postText.leadingToSuperview(offset: FeedVCConstants.postTextLeftOffset)
        postText.trailingToSuperview(offset:FeedVCConstants.postTextRightOffset)
        
        photoAttachmentConstraintsSetup()
        
        buttonViewBlock.leadingToSuperview()
        buttonViewBlock.trailingToSuperview()
        buttonViewBlock.bottomToSuperview()
        buttonViewBlock.height(FeedVCConstants.buttonViewHeight)
        
        
    }
    
    
    
    
    // Конфигурирование ячейки (наполнение данными)
    func setupCell(viewModel: FeedViewModel.Cell) {
        

                        if viewModel.userLikes == 1 {
                            likesIcon.image = UIImage(named: FeedVCConstants.buttonsLikesIconNameSet)
            
                        } else {
                            likesIcon.image = UIImage(named: FeedVCConstants.buttonsLikesIconNameUnset)
                        }
    
        
       

//
        
        
        
        
        
        likesLabel.text = viewModel.likes
        let tapLikeGesture = UITapGestureRecognizer(target: self, action: #selector(setLike))
        likeActionButton.addGestureRecognizer(tapLikeGesture)
        
        titleLabel.text = viewModel.name
        titleIconImage.set(imageUrl: viewModel.iconUrlString)
        timeLabel.text = viewModel.date
        postText.text = viewModel.text
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
        postImageView.topToBottom(of: postText, offset: FeedVCConstants.postImageViewTopOffset)
        postImageView.width(to: cardView)
        postImageView.height(self.photoAttachmentHeight)
    }
    
    // MARK: View лайков
    
    // Метод, изменяющий переменную likes
    private func getLikesCount(viewModel: FeedCellViewModel) {
        guard let likes = Int(viewModel.likes ?? "0") else { return }
        self.likes = likes
    }
    

    
    // Метод изменения иконки и количества лайков и отправки запроса в API при нажатии
    
    func changeLikeStatus(viewModel: FeedCellViewModel) {
        if viewModel.userLikes == 0 {
            likesIcon.image = UIImage(named: "liked")
            NetworkService.shared.addLike(sourceID: viewModel.sourceID!, postID: viewModel.postID!)
        } else {
            likesIcon.image = UIImage(named: "like")
        }
    }
    
   
 
        
        
        
   
    
    // Метод, сбрасывающий и устанавливающий констрейнты для View с лайками
    private func likesViewConstraintsSetup(likesViewWidth: CGFloat) {
        likesView.constraints.deActivate()
        
        likesView.leadingToSuperview(offset: FeedVCConstants.buttonsViewLeftOffset)
        likesView.topToSuperview(offset: FeedVCConstants.buttonsViewTopOffset)
        likesView.bottomToSuperview(offset: FeedVCConstants.buttonsViewBottomOffset)
        likesView.centerYToSuperview()
        likesView.width(likesViewWidth)
        
        likesIcon.leadingToSuperview(offset: FeedVCConstants.buttonsIconLeftOffset)
        likesIcon.centerYToSuperview()
        likesIcon.width(FeedVCConstants.buttonsIconWidth)
        likesIcon.height(FeedVCConstants.buttonsIconHeight)
        
        likesLabel.leadingToTrailing(of: likesIcon, offset: FeedVCConstants.buttonsLabelLeftOffset)
        likesLabel.centerYToSuperview()
        
        likeActionButton.edgesToSuperview()
    }
    
    // Метод, изменяющий ширину view в зависимости от кол-ва лайков
    private func changeWidthLikesView() {
        switch self.likes {
        case 0...9:
            likesViewConstraintsSetup(likesViewWidth: FeedVCConstants.buttonsViewWidthForOneCountNumbers)
        case 10...99:
            likesViewConstraintsSetup(likesViewWidth: FeedVCConstants.buttonsViewWidthForTwoCountNumbers)
        case 100...999:
            likesViewConstraintsSetup(likesViewWidth: FeedVCConstants.buttonsViewWidthForThreeCountNumbers)
        case 1000...9999:
            likesViewConstraintsSetup(likesViewWidth: FeedVCConstants.buttonsViewWidthForFourCountNumbers)
        default:
            break
        }
    }
    
    @objc func setLike() {
        tapLike?()
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
        
        commentsView.leadingToTrailing(of: likesView, offset: FeedVCConstants.buttonsViewLeftOffset)
        commentsView.topToSuperview(offset: FeedVCConstants.buttonsViewTopOffset)
        commentsView.bottomToSuperview(offset: FeedVCConstants.buttonsViewBottomOffset)
        commentsView.centerYToSuperview()
        commentsView.width(commentsViewWidth)
        
        commentsIcon.leadingToSuperview(offset: FeedVCConstants.buttonsIconLeftOffset)
        commentsIcon.centerYToSuperview()
        commentsIcon.width(FeedVCConstants.buttonsIconWidth)
        commentsIcon.height(FeedVCConstants.buttonsIconHeight)
        
        commentsLabel.leadingToTrailing(of: commentsIcon, offset: FeedVCConstants.buttonsLabelLeftOffset)
        commentsLabel.centerYToSuperview()
    }
    
    // Метод, изменяющий ширину view в зависимости от кол-ва комментариев
    private func changeWidthCommentsView() {
        switch self.comments {
        case 0...9:
            commentsViewConstraintsSetup(commentsViewWidth: FeedVCConstants.buttonsViewWidthForOneCountNumbers)
        case 10...99:
            commentsViewConstraintsSetup(commentsViewWidth: FeedVCConstants.buttonsViewWidthForTwoCountNumbers)
        case 100...999:
            commentsViewConstraintsSetup(commentsViewWidth: FeedVCConstants.buttonsViewWidthForThreeCountNumbers)
        case 1000...9999:
            commentsViewConstraintsSetup(commentsViewWidth: FeedVCConstants.buttonsViewWidthForFourCountNumbers)
        case 10000...99999:
            commentsViewConstraintsSetup(commentsViewWidth: FeedVCConstants.buttonsViewWidthForFiveCountNumbers)
        case 100000...999999:
            commentsViewConstraintsSetup(commentsViewWidth: FeedVCConstants.buttonsViewWidthForSixCountNumbers)
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
        
        repostsView.leadingToTrailing(of: commentsView, offset: FeedVCConstants.buttonsViewLeftOffset)
        repostsView.topToSuperview(offset: FeedVCConstants.buttonsViewTopOffset)
        repostsView.bottomToSuperview(offset: FeedVCConstants.buttonsViewBottomOffset)
        repostsView.centerYToSuperview()
        repostsView.width(repostsViewWidth)
        
        repostsIcon.leadingToSuperview(offset: FeedVCConstants.buttonsIconLeftOffset)
        repostsIcon.centerYToSuperview()
        repostsIcon.width(FeedVCConstants.buttonsIconWidth)
        repostsIcon.height(FeedVCConstants.buttonsIconHeight)
        
        repostsLabel.leadingToTrailing(of: repostsIcon, offset: FeedVCConstants.buttonsLabelLeftOffset)
        repostsLabel.centerYToSuperview()
    }
    
    // Метод, изменяющий ширину view в зависимости от кол-ва репостов
    private func changeWidthRepostsView() {
        switch self.reposts {
        case 0...9:
            repostsViewConstraintsSetup(repostsViewWidth: FeedVCConstants.buttonsViewWidthForOneCountNumbers)
        case 10...99:
            repostsViewConstraintsSetup(repostsViewWidth: FeedVCConstants.buttonsViewWidthForTwoCountNumbers)
        case 100...999:
            repostsViewConstraintsSetup(repostsViewWidth: FeedVCConstants.buttonsViewWidthForThreeCountNumbers)
        case 1000...9999:
            repostsViewConstraintsSetup(repostsViewWidth: FeedVCConstants.buttonsViewWidthForFourCountNumbers)
        case 10000...99999:
            repostsViewConstraintsSetup(repostsViewWidth: FeedVCConstants.buttonsViewWidthForFiveCountNumbers)
        case 100000...999999:
            repostsViewConstraintsSetup(repostsViewWidth: FeedVCConstants.buttonsViewWidthForSixCountNumbers)
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
        
        viewsView.trailing(to: buttonViewBlock, offset: FeedVCConstants.buttonsViewRightOffset)
        viewsView.topToSuperview(offset: FeedVCConstants.buttonsViewTopOffset)
        viewsView.bottomToSuperview(offset: FeedVCConstants.buttonsViewBottomOffset)
        viewsView.centerYToSuperview()
        viewsView.width(viewsViewWidth)
        
        viewsIcon.trailingToLeading(of: viewsLabel)
        viewsIcon.centerYToSuperview()
        viewsIcon.width(FeedVCConstants.buttonsIconWidth)
        viewsIcon.height(FeedVCConstants.buttonsIconHeight)
        
        viewsLabel.trailing(to: viewsView, offset: FeedVCConstants.buttonsViewRightOffset)
        viewsLabel.centerYToSuperview()
    }
    
    // Метод, изменяющий ширину view в зависимости от кол-ва просмотров
    private func changeWidthViewsView() {
        switch self.views {
        case 0...9:
            viewsViewConstraintsSetup(viewsViewWidth: FeedVCConstants.buttonsViewWidthForOneCountNumbers)
        case 10...99:
            viewsViewConstraintsSetup(viewsViewWidth: FeedVCConstants.buttonsViewWidthForTwoCountNumbers)
        case 100...999:
            viewsViewConstraintsSetup(viewsViewWidth: FeedVCConstants.buttonsViewWidthForThreeCountNumbers)
        case 1000...9999:
            viewsViewConstraintsSetup(viewsViewWidth: FeedVCConstants.buttonsViewWidthForFourCountNumbers)
        case 10000...99999:
            viewsViewConstraintsSetup(viewsViewWidth: FeedVCConstants.buttonsViewWidthForFiveCountNumbers)
        case 100000...999999:
            viewsViewConstraintsSetup(viewsViewWidth: FeedVCConstants.buttonsViewWidthForSixCountNumbers)
        default:
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
