//
//  NewsFeedCellViewModel.swift
//  VKNewsFeed
//
//  Created by Роман Елфимов on 29.06.2021.
//

import Foundation
import UIKit

// Сделали модель не через структуру, а через протокол
protocol FeedCellViewModel {
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    
    var photoAttachments: [FeedCellPhotoAttachmentViewModel] { get }
    
    var sizes: FeedCellSizes { get }
}

protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var attachmentFrame: CGRect { get }
    
    var bottomViewFrame: CGRect { get }
    var totalHeight: CGFloat { get }
    
    var moreTextButtonFrame: CGRect { get }
}

protocol FeedCellPhotoAttachmentViewModel {
    var photUrlString: String? { get }
    var width: Int { get }
    var height: Int { get }
}
