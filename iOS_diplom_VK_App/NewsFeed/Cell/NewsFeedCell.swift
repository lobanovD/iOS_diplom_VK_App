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
        cardView.layer.cornerRadius = VCConstants.cardViewLayerCornerRadius
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
        titleIconImage.layer.cornerRadius = VCConstants.titleImageLayerCornerRadius
        titleIconImage.clipsToBounds = true
        return titleIconImage
    }()
    
    // Название группы/имя пользователя
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = VCConstants.titleLabelFont
        return titleLabel
    }()
    
    // Время поста
    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = VCConstants.timeLabelFont
        return timeLabel
    }()
    
    // Текст поста
    private lazy var postText: UILabel = {
        let postText = UILabel()
        postText.font = VCConstants.postTextFontSize
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
        likesView.layer.cornerRadius = VCConstants.buttonsViewLayerCornerRadius
        likesView.clipsToBounds = true
        return likesView
    }()
    
    private  lazy var likeActionButton: UIButton = {
        let likeActionButton = UIButton()
        likeActionButton.layer.cornerRadius = VCConstants.buttonsViewLayerCornerRadius
        likeActionButton.clipsToBounds = true
        return likeActionButton
    }()
    
    private lazy var likesIcon: UIImageView = {
        let likesIcon = UIImageView()
        return likesIcon
    }()
    
    private lazy var likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.font = VCConstants.buttonsLabelFont
        likesLabel.textColor = UIColor(named: VCConstants.buttonsLabelTextColor)
        return likesLabel
    }()
    
    private lazy var commentsView: UIView = {
        let commentsView = UIView()
        commentsView.backgroundColor = .systemGray5
        commentsView.layer.cornerRadius = VCConstants.buttonsViewLayerCornerRadius
        commentsView.clipsToBounds = true
        return commentsView
    }()
    
    private lazy var commentsIcon: UIImageView = {
        let commentsIcon = UIImageView()
        commentsIcon.image = UIImage(named: VCConstants.buttonsCommentsIconName)
        return commentsIcon
    }()
    
    private lazy var commentsLabel: UILabel = {
        let commentsLabel = UILabel()
        commentsLabel.font = VCConstants.buttonsLabelFont
        commentsLabel.textColor = UIColor(named: VCConstants.buttonsLabelTextColor)
        return commentsLabel
    }()
    
    private lazy var repostsView: UIView = {
        let repostsView = UIView()
        repostsView.backgroundColor = .systemGray5
        repostsView.layer.cornerRadius = VCConstants.buttonsViewLayerCornerRadius
        repostsView.clipsToBounds = true
        return repostsView
    }()
    
    private lazy var repostsIcon: UIImageView = {
        let repostsIcon = UIImageView()
        repostsIcon.image = UIImage(named: VCConstants.buttonsRepostsIconName)
        return repostsIcon
    }()
    
    private lazy var repostsLabel: UILabel = {
        let repostsLabel = UILabel()
        repostsLabel.font = VCConstants.buttonsLabelFont
        repostsLabel.textColor = UIColor(named: VCConstants.buttonsLabelTextColor)
        return repostsLabel
    }()
    
    private lazy var viewsView: UIView = {
        let viewsView = UIView()
        viewsView.layer.cornerRadius = VCConstants.buttonsViewLayerCornerRadius
        viewsView.clipsToBounds = true
        return viewsView
    }()
    
    private lazy var viewsIcon: UIImageView = {
        let viewsIcon = UIImageView()
        viewsIcon.image = UIImage(named: VCConstants.buttonsViewsIconName)
        return viewsIcon
    }()
    
    private lazy var viewsLabel: UILabel = {
        let viewsLabel = UILabel()
        viewsLabel.font = VCConstants.buttonsLabelFont
        viewsLabel.textColor = UIColor(named: VCConstants.buttonsLabelTextColor)
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
        
        cardView.topToSuperview(offset: VCConstants.cardViewTopOffset)
        cardView.leadingToSuperview(offset: VCConstants.cardViewLeftOffset)
        cardView.trailingToSuperview(offset: VCConstants.cardViewRightOffset)
        cardView.bottomToSuperview(offset: VCConstants.cardViewBottomOffset)
        
        titleView.topToSuperview(offset: VCConstants.titleViewTopOffset)
        titleView.trailingToSuperview(offset: VCConstants.titleViewRightOffset)
        titleView.leadingToSuperview(offset: VCConstants.titleViewLeftOffset)
        titleView.height(VCConstants.titleViewHeight)
        
        titleIconImage.centerYToSuperview()
        titleIconImage.leadingToSuperview()
        titleIconImage.height(VCConstants.titleIconImageHeight)
        titleIconImage.width(VCConstants.titleIconImageWidth)
        
        titleLabel.topToSuperview(offset: VCConstants.titleLabelTopOffset)
        titleLabel.leadingToTrailing(of: titleIconImage, offset: VCConstants.titleLabelLeftOffset)
        
        timeLabel.bottomToSuperview(offset: VCConstants.timeLabelBottomOffset)
        timeLabel.leadingToTrailing(of: titleIconImage, offset: VCConstants.timeLabelRightOffset)
        
        postText.topToBottom(of: titleView, offset: VCConstants.postTextTopOffset)
        postText.leadingToSuperview(offset: VCConstants.postTextLeftOffset)
        postText.trailingToSuperview(offset:VCConstants.postTextRightOffset)
        
        photoAttachmentConstraintsSetup()
        
        buttonViewBlock.leadingToSuperview()
        buttonViewBlock.trailingToSuperview()
        buttonViewBlock.bottomToSuperview()
        buttonViewBlock.height(VCConstants.buttonViewHeight)
    }
    
    // Конфигурирование ячейки (наполнение данными)
    func setupCell(viewModel: FeedViewModel.Post) {
        // Иконка автора(группы)
        titleIconImage.set(imageUrl: viewModel.iconUrlString)
        // Имя автора (группы)
        titleLabel.text = viewModel.name
        // Дата
        let vkDateFormater = VKDateFormater()
        let date = vkDateFormater.formateDate(date: viewModel.date ?? 0)
        timeLabel.text = date
        // Текст
        postText.text = viewModel.text
        // Иконка лайков
        if viewModel.userLikes == 1 {
            likesIcon.image = UIImage(named: VCConstants.buttonsLikesIconNameSet)
        } else {
            likesIcon.image = UIImage(named: VCConstants.buttonsLikesIconNameUnset)
        }
        // Количество лайков
        likesLabel.text = "\(viewModel.likes ?? -100)"
        // Количество комментариев
        commentsLabel.text = "\(viewModel.comments ?? -100)"
        // Количество репостов
        repostsLabel.text = "\(viewModel.shares ?? -100)"
        // Количество просмотров
        viewsLabel.text = "\(viewModel.views ?? -100)"
   
        // Жест нажатия на область "лайков"
        let tapLikeGesture = UITapGestureRecognizer(target: self, action: #selector(setLike))
        likeActionButton.addGestureRecognizer(tapLikeGesture)
 
        // Обработка количества лайков, репостов, комментариев для установки ширины области каждого из них
        getLikesCount(viewModel: viewModel)
        getCommentsCount(viewModel: viewModel)
        getRepostCount(viewModel: viewModel)
        getViewsCount(viewModel: viewModel)
        
        // Обработка размеров фото
        changePhotoAttachmentHeight(viewModel: viewModel)
    }
    
    // MARK: Photo Attachment
    
    // Метод, изменяющий размер полученного фото
    private func changePhotoAttachmentHeight(viewModel: FeedPostViewModel) {
        
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
        postImageView.topToBottom(of: postText, offset: VCConstants.postImageViewTopOffset)
        postImageView.width(to: cardView)
        postImageView.height(self.photoAttachmentHeight)
    }
    
    // MARK: View лайков
    
    @objc func setLike() {
        tapLike?()
    }
    
    // Метод, изменяющий переменную likes
    private func getLikesCount(viewModel: FeedPostViewModel) {
        guard let likes = viewModel.likes else { return }
        self.likes = likes
    }
    
    // Метод, сбрасывающий и устанавливающий констрейнты для View с лайками
    private func likesViewConstraintsSetup(likesViewWidth: CGFloat) {
        likesView.constraints.deActivate()
        
        likesView.leadingToSuperview(offset: VCConstants.buttonsViewLeftOffset)
        likesView.topToSuperview(offset: VCConstants.buttonsViewTopOffset)
        likesView.bottomToSuperview(offset: VCConstants.buttonsViewBottomOffset)
        likesView.centerYToSuperview()
        likesView.width(likesViewWidth)
        
        likesIcon.leadingToSuperview(offset: VCConstants.buttonsIconLeftOffset)
        likesIcon.centerYToSuperview()
        likesIcon.width(VCConstants.buttonsIconWidth)
        likesIcon.height(VCConstants.buttonsIconHeight)
        
        likesLabel.leadingToTrailing(of: likesIcon, offset: VCConstants.buttonsLabelLeftOffset)
        likesLabel.centerYToSuperview()
        
        likeActionButton.edgesToSuperview()
    }
    
    // Метод, изменяющий ширину view в зависимости от кол-ва лайков
    private func changeWidthLikesView() {
        switch self.likes {
        case 0...9:
            likesViewConstraintsSetup(likesViewWidth: VCConstants.buttonsViewWidthForOneCountNumbers)
        case 10...99:
            likesViewConstraintsSetup(likesViewWidth: VCConstants.buttonsViewWidthForTwoCountNumbers)
        case 100...999:
            likesViewConstraintsSetup(likesViewWidth: VCConstants.buttonsViewWidthForThreeCountNumbers)
        case 1000...9999:
            likesViewConstraintsSetup(likesViewWidth: VCConstants.buttonsViewWidthForFourCountNumbers)
        default:
            break
        }
    }
    
    // MARK: View комментариев
    
    // Метод, изменяющий переменную comments
    private func getCommentsCount(viewModel: FeedPostViewModel) {
        guard let comments = viewModel.comments else { return }
        self.comments = comments
    }
    
    // Метод, сбрасывающий и устанавливающий констрейнты для View с комментариями
    private func commentsViewConstraintsSetup(commentsViewWidth: CGFloat) {
        commentsView.constraints.deActivate()
        
        commentsView.leadingToTrailing(of: likesView, offset: VCConstants.buttonsViewLeftOffset)
        commentsView.topToSuperview(offset: VCConstants.buttonsViewTopOffset)
        commentsView.bottomToSuperview(offset: VCConstants.buttonsViewBottomOffset)
        commentsView.centerYToSuperview()
        commentsView.width(commentsViewWidth)
        
        commentsIcon.leadingToSuperview(offset: VCConstants.buttonsIconLeftOffset)
        commentsIcon.centerYToSuperview()
        commentsIcon.width(VCConstants.buttonsIconWidth)
        commentsIcon.height(VCConstants.buttonsIconHeight)
        
        commentsLabel.leadingToTrailing(of: commentsIcon, offset: VCConstants.buttonsLabelLeftOffset)
        commentsLabel.centerYToSuperview()
    }
    
    // Метод, изменяющий ширину view в зависимости от кол-ва комментариев
    private func changeWidthCommentsView() {
        switch self.comments {
        case 0...9:
            commentsViewConstraintsSetup(commentsViewWidth: VCConstants.buttonsViewWidthForOneCountNumbers)
        case 10...99:
            commentsViewConstraintsSetup(commentsViewWidth: VCConstants.buttonsViewWidthForTwoCountNumbers)
        case 100...999:
            commentsViewConstraintsSetup(commentsViewWidth: VCConstants.buttonsViewWidthForThreeCountNumbers)
        case 1000...9999:
            commentsViewConstraintsSetup(commentsViewWidth: VCConstants.buttonsViewWidthForFourCountNumbers)
        case 10000...99999:
            commentsViewConstraintsSetup(commentsViewWidth: VCConstants.buttonsViewWidthForFiveCountNumbers)
        case 100000...999999:
            commentsViewConstraintsSetup(commentsViewWidth: VCConstants.buttonsViewWidthForSixCountNumbers)
        default:
            break
        }
    }
    
    // MARK: View репостов
    
    // Метод, изменяющий переменную reposts
    private func getRepostCount(viewModel: FeedPostViewModel) {
        guard let reposts = viewModel.shares else { return }
        self.reposts = reposts
    }
    
    // Метод, сбрасывающий и устанавливающий констрейнты для View с репостами
    private func repostsViewConstraintsSetup(repostsViewWidth: CGFloat) {
        repostsView.constraints.deActivate()
        
        repostsView.leadingToTrailing(of: commentsView, offset: VCConstants.buttonsViewLeftOffset)
        repostsView.topToSuperview(offset: VCConstants.buttonsViewTopOffset)
        repostsView.bottomToSuperview(offset: VCConstants.buttonsViewBottomOffset)
        repostsView.centerYToSuperview()
        repostsView.width(repostsViewWidth)
        
        repostsIcon.leadingToSuperview(offset: VCConstants.buttonsIconLeftOffset)
        repostsIcon.centerYToSuperview()
        repostsIcon.width(VCConstants.buttonsIconWidth)
        repostsIcon.height(VCConstants.buttonsIconHeight)
        
        repostsLabel.leadingToTrailing(of: repostsIcon, offset: VCConstants.buttonsLabelLeftOffset)
        repostsLabel.centerYToSuperview()
    }
    
    // Метод, изменяющий ширину view в зависимости от кол-ва репостов
    private func changeWidthRepostsView() {
        switch self.reposts {
        case 0...9:
            repostsViewConstraintsSetup(repostsViewWidth: VCConstants.buttonsViewWidthForOneCountNumbers)
        case 10...99:
            repostsViewConstraintsSetup(repostsViewWidth: VCConstants.buttonsViewWidthForTwoCountNumbers)
        case 100...999:
            repostsViewConstraintsSetup(repostsViewWidth: VCConstants.buttonsViewWidthForThreeCountNumbers)
        case 1000...9999:
            repostsViewConstraintsSetup(repostsViewWidth: VCConstants.buttonsViewWidthForFourCountNumbers)
        case 10000...99999:
            repostsViewConstraintsSetup(repostsViewWidth: VCConstants.buttonsViewWidthForFiveCountNumbers)
        case 100000...999999:
            repostsViewConstraintsSetup(repostsViewWidth: VCConstants.buttonsViewWidthForSixCountNumbers)
        default:
            break
        }
    }
    
    // MARK: View просмотров
    
    // Метод, изменяющий переменную views
    private func getViewsCount(viewModel: FeedPostViewModel) {
        guard let views = viewModel.views else { return }
        self.views = views
    }
    
    // Метод, сбрасывающий и устанавливающий констрейнты для View с просмотрами
    private func viewsViewConstraintsSetup(viewsViewWidth: CGFloat) {
        viewsView.constraints.deActivate()
        
        viewsView.trailing(to: buttonViewBlock, offset: VCConstants.buttonsViewRightOffset)
        viewsView.topToSuperview(offset: VCConstants.buttonsViewTopOffset)
        viewsView.bottomToSuperview(offset: VCConstants.buttonsViewBottomOffset)
        viewsView.centerYToSuperview()
        viewsView.width(viewsViewWidth)
        
        viewsIcon.trailingToLeading(of: viewsLabel)
        viewsIcon.centerYToSuperview()
        viewsIcon.width(VCConstants.buttonsIconWidth)
        viewsIcon.height(VCConstants.buttonsIconHeight)
        
        viewsLabel.trailing(to: viewsView, offset: VCConstants.buttonsViewRightOffset)
        viewsLabel.centerYToSuperview()
    }
    
    // Метод, изменяющий ширину view в зависимости от кол-ва просмотров
    private func changeWidthViewsView() {
        switch self.views {
        case 0...9:
            viewsViewConstraintsSetup(viewsViewWidth: VCConstants.buttonsViewWidthForOneCountNumbers)
        case 10...99:
            viewsViewConstraintsSetup(viewsViewWidth: VCConstants.buttonsViewWidthForTwoCountNumbers)
        case 100...999:
            viewsViewConstraintsSetup(viewsViewWidth: VCConstants.buttonsViewWidthForThreeCountNumbers)
        case 1000...9999:
            viewsViewConstraintsSetup(viewsViewWidth: VCConstants.buttonsViewWidthForFourCountNumbers)
        case 10000...99999:
            viewsViewConstraintsSetup(viewsViewWidth: VCConstants.buttonsViewWidthForFiveCountNumbers)
        case 100000...999999:
            viewsViewConstraintsSetup(viewsViewWidth: VCConstants.buttonsViewWidthForSixCountNumbers)
        default:
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
