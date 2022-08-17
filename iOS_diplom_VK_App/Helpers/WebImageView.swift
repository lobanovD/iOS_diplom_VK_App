//
//  WebImageView.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 16.08.2022.
//

import Foundation
import UIKit

// Класс для работы с изображениями, полученными из API

final class WebImageView: UIImageView {
    
    // Метод возвращает UIImage из строки с URL
    func set(imageUrl: String?) {
        guard let imageUrl = imageUrl, let url = URL(string: imageUrl) else {
            self.image = nil
            return }
        
        // Проверка, существует ли изображение в кэше
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
            return
        }
        // если к кэше нет данного изображения, получаем его из сети
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, _ in
            
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.image = UIImage(data: data)
                    // помещаем в кэш
                    self?.handleLoadedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }
    
    // Метод, помещающий изображение в кэш
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}
