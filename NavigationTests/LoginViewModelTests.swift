//
//  LoginViewModelTests.swift
//  NavigationTests
//
//  Created by Евгения Шевякова on 05.11.2023.
//

import XCTest
@testable import Navigation

final class LoginViewModelTests: XCTestCase {
    
    func testInitialState() {
        let viewModel = LoginViewModel()
        XCTAssertEqual(viewModel.state, .initial)
    }
    
    func testErrorEmailState() {
        let viewModel = LoginViewModel()
        viewModel.handleError(.incorrectEmail)
        XCTAssertEqual(viewModel.state, .errorEmail)
    }
    
    func testErrorPasswordState() {
        let viewModel = LoginViewModel()
        viewModel.handleError(.incorrectPassword)
        XCTAssertEqual(viewModel.state, .errorPassword)
    }
    
    func testEmptyFieldsState() {
        let viewModel = LoginViewModel()
        viewModel.handleError(.emptyFields)
        XCTAssertEqual(viewModel.state, .emptyFields)
    }
    
    func testUpdate() {
        let testEmail = "test@email.com"
        
        let fakeLoginDelegate = MockLoginViewControllerDelegate()
        fakeLoginDelegate.fakeResult = .success(testEmail)
        let viewModel = LoginViewModel(contentFactory: fakeLoginDelegate)
        viewModel.updateState(viewInput: .loginButtonTapped(authData: .init(email: testEmail, password: "test_password")))
        XCTAssertEqual(viewModel.state, .initial)
    }

}

class MockLoginViewControllerDelegate: LoginViewControllerDelegate {
    var fakeResult: Result<String, AuthError>!
    
    func check(email: String, password: String, completion: @escaping (Result<String, AuthError>) -> Void) {
        completion(fakeResult)
    }
}
