//
//  FeedViewController.swift
//  VKNewsFeed
//
//  Created by Роман Елфимов on 26.06.2021.
//

import UIKit

class FeedViewController: UIViewController {

    private var fethcer: DataFetcher = NetworkDataFethcer(networking: NetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        fethcer.getFeed { feedResponse in
            guard let feedResponse = feedResponse else { return }
            feedResponse.items.map { feedItem in
                print(feedItem.text)
            }
        }

     
        
        view.backgroundColor = .blue
    }
    

  

}
