//
//  MenuController.swift
//  Restaurant
//
//  Created by Denis Bystruev on 13/11/2018.
//  Copyright © 2018 Denis Bystruev. All rights reserved.
//

import UIKit

class MenuController {
    let baseURL = URL(string: "http://api.armenu.net:8090/")!
    
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoryURL) {
            data, response, error in
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                completion(nil)
                return
            }
            
            guard let categories = jsonDictionary?["categories"] as? [String] else {
                completion(nil)
                return
            }
            
            completion(categories)
        }
        task.resume()
    }
    
    func fetchMenuItems(
        forCategory categoryName: String,
        completion: @escaping (([MenuItem]?) -> Void)
    ) {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        let task = URLSession.shared.dataTask(with: menuURL) {
            data, response, error in
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let menuItems = try? jsonDecoder.decode(
                MenuItems.self,
                from: data
            ) else {
                completion(nil)
                return
            }
            
            completion(menuItems.items)
        }
        task.resume()
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        guard var components = URLComponents(
            url: url,
            resolvingAgainstBaseURL: false
        ) else {
            completion(nil)
            return
        }
        
        components.host = baseURL.host
        
        guard let url = components.url else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }
        task.resume()
        
    }
}
