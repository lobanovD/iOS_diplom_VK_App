//
//  CalculateCellHeight.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 23.08.2022.
//

import Foundation
import UIKit

final class CalculateCellHeight {
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    
    // Вычисление общей высоты ячейки
    func calculateCellTotalHeight(photoAttachment: FeedCellPhotoAttachmentViewModel?, text: String?) -> CGFloat {
        // Постоянная высота заголовка поста
        let titleHeight: CGFloat = FeedVCConstants.titleViewHeight + FeedVCConstants.titleViewTopOffset
        // Высота текста
        let textHeight = calculateTextHeight(text: text) + FeedVCConstants.postTextTopOffset
        // Высота attachment
        let attachmentHeight = calculatePhotoAttachmentHeight(photoAttachment: photoAttachment) + FeedVCConstants.postImageViewTopOffset
        
        // Высота блока кнопок
        let buttonBlockHeight = FeedVCConstants.buttonViewHeight
        var topOffsetOfButtonsBlock: CGFloat = 0
        
        if photoAttachment != nil {
            topOffsetOfButtonsBlock = FeedVCConstants.topOffsetOfButtonsBlock
        } else {
            topOffsetOfButtonsBlock = 0
        }
        
        // Общая высота
        let totalHeight = titleHeight + attachmentHeight + textHeight + buttonBlockHeight + topOffsetOfButtonsBlock
        return totalHeight
    }
    
    // Вычисление высоты текста
    func calculateTextHeight(text: String?) -> CGFloat {
        guard let text = text else { return 0 }
        
        // Ширина текста
        let screenWidth = screenWidth - (FeedVCConstants.cardViewLeftOffset + FeedVCConstants.cardViewRightOffset + FeedVCConstants.postTextLeftOffset + FeedVCConstants.postTextRightOffset)
        
        //  Высота текста
        let textHeight = text.height(textWidth: screenWidth, font: FeedVCConstants.postTextFontSize)
        return textHeight
    }
    
    // вычисление высоты Photo Attachment
    func calculatePhotoAttachmentHeight(photoAttachment: FeedCellPhotoAttachmentViewModel?) -> CGFloat {
        guard let photoAttachment = photoAttachment else { return 0 }
        let imageWidth = screenWidth - (FeedVCConstants.cardViewLeftOffset + FeedVCConstants.cardViewRightOffset)
        let ratio = CGFloat(photoAttachment.width) / imageWidth
        // Вычисление высоты attachment
        let attachmentHeight: CGFloat = CGFloat(photoAttachment.height) / ratio
        return attachmentHeight
    }
}
