//
//  UIExtensions.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 20.08.2022.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
