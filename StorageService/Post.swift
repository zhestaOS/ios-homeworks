//
//  Post.swift
//  Navigation
//
//  Created by Евгения Шевякова on 02.12.2021.
//

import Foundation

public struct Post {
    public var author: String
    public var image: String
    public var description: String
    public var likes: Int
    public var views: Int
    
    public init(author: String, image: String, description: String, likes: Int, views: Int) {
        self.author = author
        self.image = image
        self.description = description
        self.likes = likes
        self.views = views
    }
}
