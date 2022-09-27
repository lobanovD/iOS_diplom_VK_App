//
//  String + Height.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 17.08.2022.
//

import Foundation
import UIKit

// Возвращает высоту, которую занимает текст, заданного размера
extension String {
    func height(textWidth: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: textWidth, height: .greatestFiniteMagnitude)
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font: font],
                                     context: nil)
        return size.height
    }


    func truncated(after count: Int) -> String {
        let truncateAfter = index(startIndex, offsetBy: count)
        guard endIndex > truncateAfter else { return self }
        return String(self[startIndex..<truncateAfter]) + "…"
    }

    
}




