//
//  NetworkManager.swift
//  Navigation
//
//  Created by Евгения Шевякова on 22.07.2023.
//

import Foundation

enum AppConfiguration {
    case people(URL)
    case starships(URL)
    case planets(URL)
    
    var url: URL {
        switch self {
        case let .people(url):
            return url
        case let .starships(url):
            return url
        case let .planets(url):
            return url
        }
    }
}

struct NetworkManager {
    
    static func request(for configuration: AppConfiguration) {
        
        let url = configuration.url
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
           
            if let error {
                    print(error.localizedDescription)
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Error when getting response")
                    return
                }

                if !((200..<300).contains(httpResponse.statusCode)) {
                    print("Error, status code = \(httpResponse.statusCode)")
                    return
                }

                guard let data else {
                    print("Error, data is nil")
                    return
                }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error parsing data, json not cast to [String: Any]")
                    return
                }
                
                guard let name = json["name"] as? String else {
                    print("Error parsing data, no 'name' key")
                    return
                }
                
                print(name)
                print("ALL HEADER FIELDS:", httpResponse.allHeaderFields, "STATUS CODE:", httpResponse.statusCode)
//                ErrorDomain Code=-1009 "The Internet connection appears to be offline."
                
            } catch {
                print(error)
            }
            
        }
        task.resume()
        
    }
}
