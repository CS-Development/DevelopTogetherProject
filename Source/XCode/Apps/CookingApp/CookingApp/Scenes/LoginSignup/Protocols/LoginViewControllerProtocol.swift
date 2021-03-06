//
//  LoginViewControllerProtocol.swift
//  CookingApp
//
//  Created by Christian Slanzi on 27.04.21.
//

import Foundation

protocol LoginViewControllerProtocol: class {
    func clearUserNameField()
    func clearPasswordField()
    func enableLoginButton(_ status: Bool)
    func enableCreateAccountButton(_ status: Bool)
    func hideKeyboard()
    
    func showLoginResult(_ result: Bool, error: String?)
}
