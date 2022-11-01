//
//  String+Height.swift
//  VKNewsFeed
//
//  Created by Роман Елфимов on 29.06.2021.
//

import UIKit

// Считаем высоту на основе полученного текста (шрифт и тд)
extension String {
    
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font: font],
                                     context: nil)
        
        return ceil(size.height)
    }
    
}
