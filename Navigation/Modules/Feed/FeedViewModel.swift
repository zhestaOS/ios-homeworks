//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Евгения Шевякова on 29.06.2023.
//

import Foundation

protocol FeedViewModelProtocol: ViewModelProtocol {
    func checkWord(word: String?) -> Bool
}

final class FeedViewModel: FeedViewModelProtocol {
    private let feedModel = FeedModel.shared
    
    func checkWord(word: String?) -> Bool {
        feedModel.check(word: word)
    }
}
