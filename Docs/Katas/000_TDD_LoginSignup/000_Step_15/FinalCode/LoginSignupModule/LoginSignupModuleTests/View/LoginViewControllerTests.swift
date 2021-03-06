//
//  LoginViewControllerTests.swift
//  LoginSignupModuleTests
//

import XCTest
@testable import LoginSignupModule

class LoginViewControllerTests: XCTestCase {
    
    fileprivate var validUserName = "abcdefghij"
    fileprivate let validPassword = "D%io7AFn9Y"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
    
    func testViewDidLoad_Calls_PerformInitialSetup_OnViewModel() {
        let expectation = self.expectation(description: "expected performInitialViewSetup() to be called")
        let loginViewController = LoginViewController()
        let viewModel = MockLoginViewModel(view: loginViewController)
        viewModel.performInitialViewSetupExpectation = expectation
        loginViewController.viewModel = viewModel
        loginViewController.viewDidLoad()
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testUserNameDidEndOnExit_Calls_UserNameDidEndOnExit_OnViewModel() {
        
        let expectation = self.expectation(description: "expected userNameDidEndOnExit() to be called")
        
        let loginViewController = LoginViewController()
        
        let viewModel = MockLoginViewModel(view: loginViewController)
        viewModel.userNameDidEndOnExitExpectation = expectation
        
        loginViewController.viewModel = viewModel
        
        loginViewController.userNameDidEndOnExit(self)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testPasswordDidEndOnExit_Calls_PasswordDidEndOnExit_OnViewModel() {
        
        let expectation = self.expectation(description: "expected passwordDidEndOnExit() to be called")
        
        let loginViewController = LoginViewController()
        
        let viewModel = MockLoginViewModel(view: loginViewController)
        viewModel.passwordDidEndOnExitExpectation = expectation
        
        loginViewController.viewModel = viewModel
        
        loginViewController.passwordDidEndOnExit(self)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testLogin_ValidUserNameAndPassword_Calls_Login_OnViewModel_WithExpectedUserName() {
        
        let expectation = self.expectation(description: "expected login() to be called")
        
        let userNameTextFieldStub = UITextFieldStub(text: validUserName)
        let passwordTextFieldStub = UITextFieldStub(text: "")
        
        let loginViewController = LoginViewController()
        loginViewController.userNameTextField = userNameTextFieldStub
        loginViewController.passwordTextField = passwordTextFieldStub
        
        let viewModel = MockLoginViewModel(view: loginViewController)
        viewModel.loginExpectation = (expectation,
                                      expectedUserName: validUserName,
                                      expectedPassword: "")
        
        loginViewController.viewModel = viewModel
        
        loginViewController.login(self)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testLogin_ValidUserNameAndPassword_Calls_Login_OnViewModel_WithExpectedPassword() {
        
        let expectation = self.expectation(description: "expected login() to be called")
        
        let userNameTextFieldStub = UITextFieldStub(text: "")
        let passwordTextFieldStub = UITextFieldStub(text: validPassword)
        
        let loginViewController = LoginViewController()
        loginViewController.userNameTextField = userNameTextFieldStub
        loginViewController.passwordTextField = passwordTextFieldStub
        
        let viewModel = MockLoginViewModel(view: loginViewController)
        viewModel.loginExpectation = (expectation,
                                      expectedUserName: "",
                                      expectedPassword: validPassword)
        
        loginViewController.viewModel = viewModel
        
        loginViewController.login(self)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testTextFieldShouldChangeCharacters_userNameTextField_Calls_UserNameUpdated_OnViewModel_WithExpectedUsername() {
        
        let expectation = self.expectation(description: "expected userNameUpdated() to be called")
        
        let userNameTextFieldStub = UITextFieldStub(text: validUserName)
        let passwordTextFieldStub = UITextFieldStub(text: validPassword)
        
        let loginViewController = LoginViewController()
        loginViewController.userNameTextField = userNameTextFieldStub
        loginViewController.passwordTextField = passwordTextFieldStub
        
        let viewModel = MockLoginViewModel(view: loginViewController)
        viewModel.userNameUpdatedExpectation = (expectation,
                                                expectedValue: validUserName)
        
        loginViewController.viewModel = viewModel
        
        let _ = loginViewController.textField(userNameTextFieldStub,
                                              shouldChangeCharactersIn: NSMakeRange(0, 1),
                                              replacementString: "A")
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testTextFieldShouldChangeCharacters_passwordTextField_Calls_PasswordUpdated_OnViewModel_WithExpectedUsername() {
        
        let expectation = self.expectation(description: "expected passwordUpdated() to be called")
        
        let userNameTextFieldStub = UITextFieldStub(text: validUserName)
        let passwordTextFieldStub = UITextFieldStub(text: validPassword)
        
        let loginViewController = LoginViewController()
        loginViewController.userNameTextField = userNameTextFieldStub
        loginViewController.passwordTextField = passwordTextFieldStub
        
        let viewModel = MockLoginViewModel(view: loginViewController)
        viewModel.passwordUpdatedExpectation = (expectation,
                                                expectedValue: validPassword)
        
        loginViewController.viewModel = viewModel
        
        let _ = loginViewController.textField(passwordTextFieldStub,
                                              shouldChangeCharactersIn: NSMakeRange(0, 1),
                                              replacementString: "A")
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }

}
