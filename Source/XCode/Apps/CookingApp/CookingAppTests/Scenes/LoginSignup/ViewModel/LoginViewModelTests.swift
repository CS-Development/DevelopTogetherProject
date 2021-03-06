//
//  LoginViewModelTests.swift
//  CookingAppTests
//
//  Created by Christian Slanzi on 27.04.21.
//

import XCTest
@testable import CookingApp

class LoginViewModelTests: XCTestCase {
    
    fileprivate var mockLoginViewController: MockLoginViewController?
    
    fileprivate var validUserName = "abcdefghij"
    fileprivate var invalidUserName = "a"

    fileprivate let validPassword = "D%io7AFn9Y"
    fileprivate let invalidPassword = "a3$Am"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockLoginViewController = MockLoginViewController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

// MARK: initialization tests
extension LoginViewModelTests {
    
    func testInit_ValidView_InstantiatesObject() {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(view: mockLoginViewController!, router: router)
        XCTAssertNotNil(viewModel)
    }
    
    func testInit_ValidView_CopiesViewToIvar() {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(view: mockLoginViewController!, router: router)
        
        if let lhs = mockLoginViewController, let rhs = viewModel.view as? MockLoginViewController {
            XCTAssertTrue(lhs === rhs)
        }
    }
}

// MARK: performInitialViewSetup tests
extension LoginViewModelTests {
    
    func testPerformInitialViewSetup_Calls_ClearUserNameField_OnViewController() {
        let expectation = self.expectation(description: "expected clearUserNameField() to be called")
        mockLoginViewController!.expectationForClearUserNameField = expectation
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(view: mockLoginViewController!, router: router)
        viewModel.performInitialViewSetup()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testPerformInitialViewSetup_Calls_ClearPasswordField_OnViewController() {
        let expectation = self.expectation(description: "expected clearPasswordField() to be called")
        mockLoginViewController!.expectationForClearPasswordField = expectation
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(view: mockLoginViewController!, router: router)
        viewModel.performInitialViewSetup()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testPerformInitialViewSetup_DisablesLoginButton_OnViewController() {
        let expectation = self.expectation(description: "expected enableLoginButton(false) to be called")
        mockLoginViewController!.expectationForEnableLoginButton = (expectation, false)
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(view: mockLoginViewController!, router: router)
        viewModel.performInitialViewSetup()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testPerformInitialViewSetup_EnablesCreateAccountButton_OnViewController() {
        let expectation = self.expectation(description: "expected enableCreateAccountButton(true) to be called")
        mockLoginViewController!.expectationForCreateAccountButton = (expectation, true)
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(view: mockLoginViewController!, router: router)
        viewModel.performInitialViewSetup()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testPerformInitialViewSetup_HideKeyboard_OnViewController() {
        let expectation = self.expectation(description: "expected hideKeyboard to be called")
        mockLoginViewController!.expectationForHideKeyboard = expectation
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(view: mockLoginViewController!, router: router)
        viewModel.performInitialViewSetup()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
}

// MARK: userNameDidEndOnExit tests
extension LoginViewModelTests {
    
    func testUserNameDidEndOnExit_Calls_HideKeyboard_OnViewController() {
        let expectation = self.expectation(description: "expected hideKeyboard() to be called")
        mockLoginViewController!.expectationForHideKeyboard = expectation
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(view: mockLoginViewController!, router: router)
        viewModel.userNameDidEndOnExit()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
}

// MARK: passwordDidEndOnExit tests
extension LoginViewModelTests {
    
    func testPasswordDidEndOnExit_Calls_HideKeyboard_OnViewController() {
        let expectation = self.expectation(description: "expected hideKeyboard() to be called")
        mockLoginViewController!.expectationForHideKeyboard = expectation
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(view: mockLoginViewController!, router: router)
        viewModel.passwordDidEndOnExit()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
}

// MARK: userNameUpdated tests
extension LoginViewModelTests {
    func testUserNameUpdated_Calls_Validate_OnUserNameValidator() {
        let expectation = self.expectation(description: "expected validate() to be called")
    
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(view: mockLoginViewController!, router: router)
        viewModel.userNameValidator = MockUserNameValidator(expectation, expectedValue: validUserName)
        
        viewModel.userNameUpdated(validUserName)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testUserNameUpdated_ValidUserName_PasswordValidated_EnablesLoginButton_OnViewController() {
        let expectation = self.expectation(description: "expected enableLogin(true) to be called")
        mockLoginViewController!.expectationForEnableLoginButton = (expectation, true)
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(view: mockLoginViewController!, router: router)
        viewModel.passwordValidated = true
        viewModel.userNameUpdated(validUserName)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testUserNameUpdated_ValidUserName_PasswordNotValidated_DisablesLoginButton_OnViewController() {
        let expectation = self.expectation(description: "expected enableLogin(false) to be called")
        mockLoginViewController!.expectationForEnableLoginButton = (expectation, false)
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(view: mockLoginViewController!, router: router)
        viewModel.passwordValidated = false
        
        viewModel.userNameUpdated(validUserName)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testUserNameUpdated_InvalidUserName_PasswordValidated_DisablesLoginButton_OnViewController() {
        let expectation = self.expectation(description: "expected enableLogin(false) to be called")
        mockLoginViewController!.expectationForEnableLoginButton = (expectation, false)
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(view: mockLoginViewController!, router: router)
        viewModel.passwordValidated = true
        
        viewModel.userNameUpdated(invalidUserName)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testUserNameUpdated_InvalidUserName_PasswordNotValidated_DisablesLoginButton_OnViewController() {
        let expectation = self.expectation(description: "expected enableLogin(false) to be called")
        mockLoginViewController!.expectationForEnableLoginButton = (expectation, false)
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(view: mockLoginViewController!, router: router)
        viewModel.passwordValidated = false
        
        viewModel.userNameUpdated(invalidUserName)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
}

// MARK: passwordUpdated tests
extension LoginViewModelTests {
    
    func testPasswordUpdated_Calls_Validate_OnPasswordValidator() {
        let expectation = self.expectation(description: "expected validate() to be called")
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(view: mockLoginViewController!, router: router)
        viewModel.passwordValidator = MockPasswordValidator(expectation, expectedValue: validPassword)
        
        viewModel.passwordUpdated(validPassword)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testPasswordUpdated_ValidPassword_UserNameValidated_EnablesLoginButton_OnViewController() {
        let expectation = self.expectation(description: "expected enableLogin(true) to be called")
        mockLoginViewController!.expectationForEnableLoginButton = (expectation, true)
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(view: mockLoginViewController!, router: router)
        viewModel.userNameValidated = true
        viewModel.passwordUpdated(validPassword)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testPasswordUpdated_ValidPassword_UserNameNotValidated_DisablesLoginButton_OnViewController() {
        let expectation = self.expectation(description: "expected enableLogin(false) to be called")
        mockLoginViewController!.expectationForEnableLoginButton = (expectation, false)
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(view: mockLoginViewController!, router: router)
        viewModel.userNameValidated = false
        
        viewModel.passwordUpdated(validPassword)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testPasswordUpdated_InvalidPassword_UserNameValidated_DisablesLoginButton_OnViewController() {
        let expectation = self.expectation(description: "expected enableLogin(false) to be called")
        mockLoginViewController!.expectationForEnableLoginButton = (expectation, false)
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(view: mockLoginViewController!, router: router)
        viewModel.userNameValidated = true
        
        viewModel.passwordUpdated(invalidPassword)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testPasswordUpdated_InvalidPassword_UserNameNotValidated_DisablesLoginButton_OnViewController() {
        let expectation = self.expectation(description: "expected enableLogin(false) to be called")
        mockLoginViewController!.expectationForEnableLoginButton = (expectation, false)
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(view: mockLoginViewController!, router: router)
        viewModel.userNameValidated = false
        
        viewModel.passwordUpdated(invalidPassword)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }

}

// MARK: login tests
extension LoginViewModelTests {
    
    func testLogin_ValidParameters_Calls_doLogin_OnLoginController() {
        let expectation = self.expectation(description: "expected doLogin() to be called")
        
        let mockLoginController = MockLoginController(expectation, expectedUserName: validUserName,
                                                      expectedPassword: validPassword)
        mockLoginController.shouldReturnTrueOnLogin = true
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(view: mockLoginViewController!, router: router)
        viewModel.loginController = mockLoginController
        //mockLoginController.loginControllerDelegate = viewModel
        
        viewModel.login(userName: validUserName, password: validPassword)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testLogin_ValidParameters_Calls_doLoginWithExpectedUserName_OnLoginController() {
        let expectation = self.expectation(description: "expected doLogin() to be called")
        
        let mockLoginController = MockLoginController(expectation,
                                                      expectedUserName: validUserName,
                                                      expectedPassword: validPassword)
        mockLoginController.shouldReturnTrueOnLogin = true
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(view: mockLoginViewController!, router: router)
        viewModel.loginController = mockLoginController
        mockLoginController.loginControllerDelegate = viewModel
        
        viewModel.login(userName: validUserName, password: validPassword)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testLogin_ValidParameters_Calls_doLoginWithExpectedPassword_OnLoginController() {
        let expectation = self.expectation(description: "expected doLogin() to be called")
        
        let mockLoginController = MockLoginController(expectation,
                                                      expectedUserName: validUserName,
                                                      expectedPassword: validPassword)
        mockLoginController.shouldReturnTrueOnLogin = true
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(view: mockLoginViewController!, router: router)
        viewModel.loginController = mockLoginController
        mockLoginController.loginControllerDelegate = viewModel
        
        viewModel.login(userName: validUserName, password: validPassword)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }

}
