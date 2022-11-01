//
//  WebImageView.swift
//  VKNewsFeed
//
//  Created by Роман Елфимов on 28.06.2021.
//

import UIKit

class WebImageView: UIImageView {
    
    private var currentURLString: String?
    
    func set(imageUrl: String?) {
        
        currentURLString = imageUrl
        
        guard let imageUrl = imageUrl, let url = URL(string: imageUrl) else { return }
        self.image = nil
        if let cashedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cashedResponse.data)
//            print("from cached")
            return
        }
        
//        print("from internet")
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, _ in
            
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    
                    self?.handleLoadedImage(data: data, response: response)
                }
            }
        }
        
        dataTask.resume()
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
         
        if responseURL.absoluteString == currentURLString {
            self.image = UIImage(data: data)
        }
    }
}
