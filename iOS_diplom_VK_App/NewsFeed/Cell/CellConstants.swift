//
//  CellConstants.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 23.08.2022.
//

import Foundation
import UIKit


struct CellConstants {
    
    
    // TODO: Сделать для айпида другие параметры
    init(){
        if UIScreen.main.bounds.width == 100 {
            
        }
    }
    
    
    // MARK: Card View
    static let cardViewTopOffset: CGFloat = 4
    static let cardViewLeftOffset: CGFloat = 8
    static let cardViewRightOffset: CGFloat = 8
    static let cardViewBottomOffset: CGFloat = -4
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
    
    // MARK: Likes View
    static let likesViewLayerCornerRadius: CGFloat = 15
    static let likesViewLeftOffset: CGFloat = 8
    static let likesViewTopOffset: CGFloat = 6
    static let likesViewBottomOffset: CGFloat = -6
    
    static let likesViewWidthForOneCountNumbers: CGFloat = 55
    static let likesViewWidthForTwoCountNumbers: CGFloat = 65
    static let likesViewWidthForThreeCountNumbers: CGFloat = 75
    static let likesViewWidthForFourCountNumbers: CGFloat = 85
    
    // MARK: Likes Image
    static let likesImageName: String = "like"
    static let likesImageLeftOffset: CGFloat = 8
    static let likesImageWidth: CGFloat = 20
    static let likesImageHeight: CGFloat = 20
    
    // MARK: Likes Label
    static let likesLabelFont: UIFont = .systemFont(ofSize: 14)
    static let likesLabelTextColor: String = "likesColor"
    static let likesLabelLeftOffset: CGFloat = 6
}
