//
//  NewsFeedCellLayoutCalculator.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 17.08.2022.
//

import Foundation
import UIKit

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}


final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    private let screneWidth: CGFloat
    
    init(screenWidth: CGFloat) {
        self.screneWidth = screenWidth
    }
    
    struct Sizes: FeedCellSizes {
        var postLableFrame: CGRect
        var attachmentFrame: CGRect
        var buttonViewFrame: CGRect
        var totalHeight: CGFloat
    }
    
    struct Constants {
        static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
        static let topViewHeiht: CGFloat = 36
        static let postLableInsets = UIEdgeInsets(top: 8 + Constants.topViewHeiht + 8, left: 8, bottom: 8, right: 8)
        static let postLabelFont = UIFont.systemFont(ofSize: 15)
        static let buttonViewHeight: CGFloat = 44
    }
    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        let cardViewWidth = screneWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        // MARK: PostLabel Frame
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLableInsets.left, y: Constants.postLableInsets.top), size: .zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLableInsets.left - Constants.postLableInsets.right
            let height = text.height(width: width, font: Constants.postLabelFont)
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        // MARK: Attachment frame
        
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLableInsets.top : postLabelFrame.maxY + Constants.postLableInsets.bottom
        
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: .zero)
        
        if let attachment  = photoAttachment {
            let photoHeight: Float = Float(attachment.height)
            let photoWidth: Float = Float(attachment.width)
            
            let ratio = CGFloat(photoHeight) / CGFloat(photoWidth)
            
            attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
        }
        
        // MARK: ButtonView frame
        
        let buttonViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        
        let buttonViewFrame = CGRect(origin: CGPoint(x: 0, y: buttonViewTop), size: CGSize(width: cardViewWidth, height: Constants.buttonViewHeight))
        
        // MARK: Total height
        let totalHeight = buttonViewFrame.maxY + Constants.cardInsets.bottom
        
        
        return Sizes(postLableFrame: postLabelFrame,
                     attachmentFrame: attachmentFrame,
                     buttonViewFrame: buttonViewFrame,
                     totalHeight: totalHeight)
    }
    
}
