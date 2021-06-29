//
//  Constants.swift
//  VKNewsFeed
//
//  Created by Роман Елфимов on 29.06.2021.
//

import UIKit

// Отступы CardView от экрана
struct Constants {
    static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    static let topViewHeight: CGFloat = 36
    static let postLabelInsets = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8, left: 8, bottom: 8, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    static let bottomViewHeight: CGFloat = 44
    
    static let bottomViewViewHeight: CGFloat = 44
    static let bottomViewViewWidth: CGFloat = 80
    
    static let bottomViewViewsIconSize: CGFloat = 24
}
