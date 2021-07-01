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
    
    
    // MARK: - Internal Properties
    private var revealPostIds = [Int]()
    private var feedResponse: FeedResponse?
    
    private let dataFetcher: DataFetcher = NetworkDataFethcer(networking: NetworkService())
    
    func makeRequest(request: NewsFeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsFeedService()
        }
        
        switch request {
        case .getNewsFeed:
            
            dataFetcher.getFeed { [weak self] feedResponse in
                
                self?.feedResponse = feedResponse
                self?.presentFeed()
            }
        case .revealPostIds(postId: let postId):
            revealPostIds.append(postId)
            presentFeed()
        case .getUser:
            dataFetcher.getUser { [weak self] userResponse in
                self?.presenter?.presentData(response: .presentUserInfo(user: userResponse))
            }
        }
    }
    
    
    private func presentFeed() {
        guard let feedResponse = feedResponse else { return }
        presenter?.presentData(response: .presentNewsFeed(feed: feedResponse, revealPostIds: revealPostIds))
    }
    
}
