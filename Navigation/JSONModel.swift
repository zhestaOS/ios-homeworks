//
//  JSONModel.swift
//  Navigation
//
//  Created by Евгения Шевякова on 25.07.2023.
//

import Foundation

struct Planet: Decodable {
    var name: String
    var rotation_period: String
    var orbitalPeriod: String
    var diameter: String
    var climate: String
    var gravity: String
    var terrain: String
    var surface_water: String
    var population: String
    var residents: [String]
    var films: [String]
    var created: String
    var edited: String
    var url: URL
    enum CodingKeys: String, CodingKey {
        case name
        case rotation_period
        case orbitalPeriod = "orbital_period"
        case diameter
        case climate
        case gravity
        case terrain
        case surface_water
        case population
        case residents
        case films
        case created
        case edited
        case url
    }
}

func getPlanetInfo(completion: ((_ orbitalPeriod: String?, _ errorText: String?) -> Void)?) {
    let url = URL(string: "https://swapi.dev/api/planets/1")!
    let session = URLSession.shared
    let task = session.dataTask(with: url) { data, response, error in
        if let error {
            completion?(nil, error.localizedDescription)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            completion?(nil, "Error with getting response")
            return
        }
        
        if !((200..<300).contains(httpResponse.statusCode)) {
            completion?(nil, "Error, status code = \(httpResponse.statusCode)")
            return
        }
        
        guard let data else {
            completion?(nil, "Error, data is nil")
            return
        }
        
        do {
            let planet = try JSONDecoder().decode(Planet.self, from: data)
            completion?(planet.orbitalPeriod, nil)
        } catch {
            print(error)
        }
    }
    task.resume()
}

func toDo(completion: ((_ toDoText: String?, _ errorText: String?) -> Void)?) {
    let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
    let session = URLSession.shared
    let task = session.dataTask(with: url) { data, response, error in
        if let error {
            completion?(nil, error.localizedDescription)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            completion?(nil, "Error with getting response")
            return
        }
        
        if !((200..<300).contains(httpResponse.statusCode)) {
            completion?(nil, "Error, status code = \(httpResponse.statusCode)")
            return
        }
        
        guard let data else {
            completion?(nil, "Error, data is nil")
            return
        }

        do {
            guard let toDo = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
                completion?(nil, "Error parsing data, answer not cast to [String: Any]")
                return
            }
            
            guard let toDoText = toDo[16]["title"] as? String else {
                completion?(nil, "Error parsing data, no 'title' key or toDoText not cast to String")
                return
            }

            completion?(toDoText, nil)
            
        } catch {
            print(error)
        }  
    }
    task.resume()
}
