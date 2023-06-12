//
//  FeedModel.swift
//  Navigation
//
//  Created by Евгения Шевякова on 16.04.2023.
//

import UIKit

final class FeedModel {
    
    // MARK: - Properties
    
    static let shared = FeedModel()

    private let secretWord = "sun"
    
    // MARK: - Life cycle
    
    private init() {}
    
    // MARK: - Methods

    func check(word: String?) -> Bool {
       
        guard let word = word, !word.isEmpty else {
            return false
        }

        return word == secretWord
    }
}
