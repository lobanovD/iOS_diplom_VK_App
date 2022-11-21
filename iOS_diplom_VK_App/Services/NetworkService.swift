//
//  NetworkService.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 09.08.2022.
//

import Foundation

protocol Networking {
    func request(path: String, methodParams: URLQueryItem, completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService {
    
    static let shared = NetworkService()
    
    // Метод получения URL запроса к API
    private func url(path: String, parameters:[URLQueryItem]) -> URL? {
        
        guard let authToken = VKAuthService.shared.token else { return nil }
        
        let token = URLQueryItem(name: APIParams.apiToken.rawValue, value: authToken)
        let version = URLQueryItem(name: APIParams.apiVersion.rawValue, value: API.version)
        
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = path

        components.queryItems = []
        for parameter in parameters {
            components.queryItems?.append(parameter)
        }
        components.queryItems?.append(token)
        components.queryItems?.append(version)
            
        guard let url = components.url else { return nil }
        print(url)
        return url
    }
    
    // Общий метод запроса данных с API
    private func request(path: String, parameters: [URLQueryItem], completion: @escaping (Data?, Error?) -> Void) {
        
        guard let url = url(path: path, parameters: parameters) else { return }
        let session = URLSession.init(configuration: .default)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, responce, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        
        task.resume()
        
    }
    
    // Метод получения новостной ленты пользователя
    func getFeed(completion: @escaping (_ responce: FeedResponceWrapped?) -> Void) {
        
        let params1 = URLQueryItem(name: GetFeed.name, value: GetFeed.value)
        let params2 = URLQueryItem(name: "count", value: "100")
        
        NetworkService.shared.request(path: GetFeed.path, parameters: [params1, params2]) { data, error in
            if let error = error {
                print(error.localizedDescription)
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let data = data else { return }
            
            let responce = try? decoder.decode(FeedResponceWrapped.self, from: data)
            
            completion(responce)
            
        }
    }
    
    // Метод получения данных пользователя
    func getUserProfile(completion: @escaping (_ responce: UserProfileResponseWrapped?) -> Void) {
        
//        let params = URLQueryItem(name: "", value: "")
//        let params2 = URLQueryItem(name: "", value: "")

        NetworkService.shared.request(path: GetUserInfo.path, parameters: []) { data, error in
            if let error = error {
                print(error.localizedDescription)
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let data = data else { return }
            
            let responce = try? decoder.decode(UserProfileResponseWrapped.self, from: data)
            
            completion(responce)
            
        }
    }
}
