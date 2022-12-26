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
    
// MARK: New feed alert
    static let alertBackgroundColor: UIColor = #colorLiteral(red: 0.1764705882, green: 0.4965524673, blue: 0.7551663518, alpha: 1)
    static let alertTextColor: UIColor = .white
    static let alertText: String = "Свежие новости"
    static let alertBorderColor: CGColor = CGColor(srgbRed: 45, green: 127, blue: 193, alpha: 1)
    static let alertBorderCornerRadius: CGFloat = 5
    static let alertBorderWidth: CGFloat = 1
    
    // MARK: Main View
    static let mainViewBackgroungColor: UIColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    
    // MARK: Notification Center
    static let reloadFavourite: String = "reloadFavourite"
    static let reloadNews: String = "reloadNews"

}


