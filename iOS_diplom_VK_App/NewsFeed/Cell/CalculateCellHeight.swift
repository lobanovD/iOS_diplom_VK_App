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
        let titleHeight: CGFloat = CellConstants.titleViewHeight + CellConstants.titleViewTopOffset
        // Высота текста
        let textHeight = calculateTextHeight(text: text) + CellConstants.postTextTopOffset
        // Высота attachment
        let attachmentHeight = calculatePhotoAttachmentHeight(photoAttachment: photoAttachment) + CellConstants.postImageViewTopOffset
        
        // Высота блока кнопок
        // TODO
        let buttonBlockHeight: CGFloat = 8
        
        // Общая высота
        let totalHeight = titleHeight + attachmentHeight + textHeight + buttonBlockHeight
        return totalHeight
    }
    
    // Вычисление высоты текста
    func calculateTextHeight(text: String?) -> CGFloat {
        guard let text = text else { return 0 }

        // Ширина текста
        let screenWidth = screenWidth - (CellConstants.cardViewLeftOffset + CellConstants.cardViewRightOffset + CellConstants.postTextLeftOffset + CellConstants.postTextRightOffset)
        
        //  Высота текста
        let textHeight = text.height(textWidth: screenWidth, font: CellConstants.postTextFontSize)
        
        return textHeight
        
    }
    
    // вычисление высоты Photo Attachment
    func calculatePhotoAttachmentHeight(photoAttachment: FeedCellPhotoAttachmentViewModel?) -> CGFloat {
        guard let photoAttachment = photoAttachment else { return 0 }
        let imageWidth = screenWidth - (CellConstants.cardViewLeftOffset + CellConstants.cardViewRightOffset)
        let ratio = CGFloat(photoAttachment.width) / imageWidth
        // Вычисление высоты attachment
        let attachmentHeight: CGFloat = CGFloat(photoAttachment.height) / ratio
        return attachmentHeight
    }
}
