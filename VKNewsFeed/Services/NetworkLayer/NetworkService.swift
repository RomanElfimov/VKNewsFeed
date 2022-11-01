//
//  NetworkService.swift
//  VKNewsFeed
//
//  Created by Роман Елфимов on 26.06.2021.
//

import Foundation

protocol Networking {
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
    
}

final class NetworkService: Networking {
    
    private let authService: AuthenticationService
    
    init(authService: AuthenticationService = SceneDelegate.shared().authService) {
        self.authService = authService
    }
    
    // MARK: - Protocol Realization Logic
    
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void) {
        
        guard let token = authService.token else { return }
        
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        
        let url = url(from: path, params: allParams)
        
        // Create request
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        
        task.resume()
        
        print(url)
    }
    
    // MARK: - Private Methods
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    // Создаем URL из компонентов
    private func url(from path: String, params: [String: String]) -> URL {
        
        var components = URLComponents()
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        
        return components.url!
    }
}
