//
//  FeedViewModelTests.swift
//  NavigationTests
//
//  Created by Евгения Шевякова on 05.11.2023.
//

import XCTest
@testable import Navigation

final class FeedViewModelTests: XCTestCase {

    func testNilWord() {
        let viewModel = FeedViewModel()
        XCTAssertEqual(false, viewModel.checkWord(word: nil))
    }
    
    func testIncorrectWord() {
        let viewModel = FeedViewModel()
        XCTAssertEqual(false, viewModel.checkWord(word: "incorrect"))
    }

    func testCorrectWord() {
        let viewModel = FeedViewModel()
        XCTAssertEqual(true, viewModel.checkWord(word: "sun"))
    }
}
