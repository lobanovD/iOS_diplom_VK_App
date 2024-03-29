//
//  CellConstants.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 23.08.2022.
//

import Foundation
import UIKit


struct FeedVCConstants {
    
    
    // TODO: Сделать для айпада другие параметры
    init(){
        if UIScreen.main.bounds.width == 100 {
            
        }
    }
    
    // MARK: Table View
    static let tableViewBottomOffset: CGFloat = 0
    
    // MARK: Card View
    static let cardViewTopOffset: CGFloat = 8
    static let cardViewLeftOffset: CGFloat = 8
    static let cardViewRightOffset: CGFloat = 8
    static let cardViewBottomOffset: CGFloat = 0
    static let cardViewLayerCornerRadius: CGFloat = 10
    
    // MARK: Title View
    static let titleViewHeight: CGFloat = 50
    static let titleViewTopOffset: CGFloat = 8
    static let titleViewLeftOffset: CGFloat = 8
    static let titleViewRightOffset: CGFloat = 8
    
    // MARK: Title Icon Image
    static let titleImageLayerCornerRadius: CGFloat = 20
    static let titleIconImageHeight: CGFloat = 40
    static let titleIconImageWidth: CGFloat = 40
    
    // MARK: Title Label
    static let titleLabelFont: UIFont = .systemFont(ofSize: 15, weight: .medium)
    static let titleLabelTopOffset: CGFloat = 6
    static let titleLabelLeftOffset: CGFloat = 6
    
    // MARK: Time Label
    static let timeLabelFont: UIFont = .systemFont(ofSize: 12, weight: .light)
    static let timeLabelBottomOffset: CGFloat = -6
    static let timeLabelRightOffset: CGFloat = 6
    
    // MARK: Text View
    static let postTextFontSize: UIFont = .systemFont(ofSize: 15)
    static let postTextTopOffset: CGFloat = 8
    static let postTextLeftOffset: CGFloat = 8
    static let postTextRightOffset: CGFloat = 8
    
    // MARK: Post Image View (фото)
    static let postImageViewTopOffset: CGFloat = 8
    
    // MARK: Buttons View
    static let buttonViewHeight: CGFloat = 40
    static let topOffsetOfButtonsBlock: CGFloat = 8
    
    
    // MARK: Buttons (Likes, Comments, Reposts, Views)
    // View
    static let buttonsViewLayerCornerRadius: CGFloat = 15
    static let buttonsViewLeftOffset: CGFloat = 8
    static let buttonsViewTopOffset: CGFloat = 6
    static let buttonsViewBottomOffset: CGFloat = -6
    static let buttonsViewRightOffset: CGFloat = -6
    
    static let buttonsViewWidthForOneCountNumbers: CGFloat = 55
    static let buttonsViewWidthForTwoCountNumbers: CGFloat = 65
    static let buttonsViewWidthForThreeCountNumbers: CGFloat = 75
    static let buttonsViewWidthForFourCountNumbers: CGFloat = 85
    static let buttonsViewWidthForFiveCountNumbers: CGFloat = 90
    static let buttonsViewWidthForSixCountNumbers: CGFloat = 95
    
    // Icon
    static let buttonsLikesIconNameSet: String = "liked"
    static let buttonsLikesIconNameUnset: String = "like"
    static let buttonsCommentsIconName: String = "comment"
    static let buttonsRepostsIconName: String = "share"
    static let buttonsViewsIconName: String = "eye"
    static let buttonsIconLeftOffset: CGFloat = 8
    static let buttonsIconWidth: CGFloat = 20
    static let buttonsIconHeight: CGFloat = 20
    
    // Label
    static let buttonsLabelFont: UIFont = .systemFont(ofSize: 14)
    static let buttonsLabelTextColor: String = "buttonsColor"
    static let buttonsLabelLeftOffset: CGFloat = 6
    
    // Full Text Button
    static let fullTextButtonColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    static let fullTextButtonTitle = "Показать полностью"
    static let fullTextButtonFont = UIFont.systemFont(ofSize: 15, weight: .medium)
    
    // Post text
    static let charCount = 400
}
