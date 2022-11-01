//
//  NewsFeedInteractor.swift
//  VKNewsFeed
//
//  Created by Роман Елфимов on 27.06.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
    func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {
    
    // MARK: - External properties
    
    var presenter: NewsFeedPresentationLogic?
    var service: NewsFeedService?
    
    func makeRequest(request: NewsFeed.Model.Request.RequestType) {
        
        if service == nil {
            service = NewsFeedService()
        }
        
        switch request {
        case .getNewsFeed:
            
            service?.getFeed(completion: { [weak self] revealPostIds, feed in
                self?.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealPostIds: revealPostIds))
            })
            
        case .getUser:
            
            service?.getUser(completion: { [weak self] user in
                self?.presenter?.presentData(response: .presentUserInfo(user: user))
            })
            
        case .revealPostIds(postId: let postId):
            
            service?.revealPostIds(forPostId: postId, completion: { [weak self] revealPostIds, feed in
                self?.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealPostIds: revealPostIds))
            })
            
        case .getNextBatch:
            print("123")
            
            self.presenter?.presentData(response: .presentFooterLoader)
            service?.getNextBatch(completion: { [weak self] (revealPostIds, feed) in
                self?.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealPostIds: revealPostIds))
            })
            
        }
    }
    
}
