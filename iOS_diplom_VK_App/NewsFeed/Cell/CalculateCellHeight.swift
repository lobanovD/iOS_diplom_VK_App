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
    func calculateCellTotalHeight(photoAttachment: CellPhotoAttachmentViewModelProtocol?, text: String?) -> CGFloat {
        print("начинаем вычисление высоты ячейки")
        
        // Постоянная высота заголовка поста
        let titleHeight: CGFloat = VCConstants.titleViewHeight + VCConstants.titleViewTopOffset
        // Высота текста
        let textHeight = calculateTextHeight(text: text) + VCConstants.postTextTopOffset
        // Высота attachment
        let attachmentHeight = calculatePhotoAttachmentHeight(photoAttachment: photoAttachment) + VCConstants.postImageViewTopOffset
        print("Высота attachment - ", attachmentHeight)
        // Высота блока кнопок
        let buttonBlockHeight = VCConstants.buttonViewHeight
        var topOffsetOfButtonsBlock: CGFloat = 0
        
        if photoAttachment != nil {
            topOffsetOfButtonsBlock = VCConstants.topOffsetOfButtonsBlock
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
        let screenWidth = screenWidth - (VCConstants.cardViewLeftOffset + VCConstants.cardViewRightOffset + VCConstants.postTextLeftOffset + VCConstants.postTextRightOffset)
        
        //  Высота текста
        let textHeight = text.height(textWidth: screenWidth, font: VCConstants.postTextFontSize)
        return textHeight
    }
    
    // вычисление высоты Photo Attachment
    func calculatePhotoAttachmentHeight(photoAttachment: CellPhotoAttachmentViewModelProtocol?) -> CGFloat {
        print("444444444444444444444444")
        print(photoAttachment)
        guard let photoAttachment = photoAttachment else { return 0 }
        guard (photoAttachment.photoUrlString) != nil else { return 0 }
        let imageWidth = screenWidth - (VCConstants.cardViewLeftOffset + VCConstants.cardViewRightOffset)
        let ratio = CGFloat(photoAttachment.width) / imageWidth
        // Вычисление высоты attachment
        let attachmentHeight: CGFloat = CGFloat(photoAttachment.height) / ratio
        return attachmentHeight
    }
}
