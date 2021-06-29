//
//  NewsFeedModels.swift
//  VKNewsFeed
//
//  Created by Роман Елфимов on 27.06.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum NewsFeed {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getNewsFeed
            }
        }
        struct Response {
            enum ResponseType {
                case presentNewsFeed(feed: FeedResponse)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case dispayNewsFeed(feedViewModel: FeedViewModel)
            }
        }
    }
}



// MARK: - View Model for cell

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
    
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        
        var photoAttachment: FeedCellPhotoAttachmentViewModel?
        
        var sizes: FeedCellSizes
    }
    
    struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel {
        var photUrlString: String?
        var width: Int
        var height: Int
    }
    
    
    let cells: [Cell]
}
