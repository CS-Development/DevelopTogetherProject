//
//  SignupViewModel.swift
//  CookingApp
//
//  Created by Christian Slanzi on 27.04.21.
//

import Foundation
import LoginSignupModule
import CommonRouting

class SignupViewModel {
    
    typealias Routes = MainRoute & Closable
    private var router: Routes?
    
    weak var view: SignupViewControllerProtocol?
    
    var userNameValidator: UserNameValidator?
    var emailAddressValidator: EmailAddressValidator?
    var passwordValidator: PasswordValidator?
    
    var userNameValidated: Bool
    var emailAddressValidated: Bool
    
    var password1Validated: Bool
    var password2Validated: Bool
    
    var password1: String?
    var password2: String?
    var passwordsAreIdentical: Bool
    
    var signupController: SignupController?
    
    init(view: SignupViewControllerProtocol, router: Routes? = nil) {
 
        self.userNameValidated = false
        self.emailAddressValidated = false
        
        self.password1Validated = false
        self.password2Validated = false
        self.passwordsAreIdentical = false
        
        self.view = view
        self.router = router
    }
    
    func performInitialViewSetup() {
        view?.clearUserNameField()
        view?.clearPasswordField()
        view?.clearConfirmPasswordField()
        view?.enableCreateButton(false)
        view?.enableCancelButton(true)
    }
    
    func userNameDidEndOnExit() {
        view?.hideKeyboard()
    }
    
    func passwordDidEndOnExit() {
        view?.hideKeyboard()
    }
    
    func confirmPasswordDidEndOnExit() {
        view?.hideKeyboard()
    }
    
    func emailAddressDidEndOnExit() {
        view?.hideKeyboard()
    }
    
    func userNameUpdated(_ value: String?) {
        
        guard let value = value else {
            view?.enableCreateButton(false)
            return
        }
        
        let validator = self.userNameValidator ?? UserNameValidator()
        userNameValidated = validator.validate(value)
        
        if userNameValidated == false {
            view?.enableCreateButton(false)
            return
        }
        
        if password1Validated == true &&
            password2Validated == true &&
            passwordsAreIdentical == true &&
            emailAddressValidated == true {
            
            view?.enableCreateButton(true)
            return
        }
        
        view?.enableCreateButton(false)
    }
    
    func emailAddressUpdated(_ value: String?) {
        
        guard let value = value else {
            view?.enableCreateButton(false)
            return
        }
        
        let validator = self.emailAddressValidator ?? EmailAddressValidator()
        emailAddressValidated = validator.validate(value)
        
        if emailAddressValidated == false {
            view?.enableCreateButton(false)
            return
        }
        
        if password1Validated == true &&
            password2Validated == true &&
            passwordsAreIdentical == true &&
            userNameValidated == true &&
            emailAddressValidated == true {
            
            view?.enableCreateButton(true)
            return
        }
        
        view?.enableCreateButton(false)
    }
    
    func passwordUpdated(_ value: String?) {
        
        self.password1 = value
        
        guard let password1 = self.password1 else {
            view?.enableCreateButton(false)
            return
        }
        
        if let password2 = password2 {
            passwordsAreIdentical = password1.compare(password2) == .orderedSame
        } else {
            passwordsAreIdentical = false
        }
        
        let validator = self.passwordValidator ?? PasswordValidator()
        password1Validated = validator.validate(password1)
        
        if userNameValidated == false {
            view?.enableCreateButton(false)
            return
        }
        
        if password1Validated == true &&
            password2Validated == true &&
            passwordsAreIdentical == true &&
            userNameValidated == true &&
            emailAddressValidated == true {
            
            view?.enableCreateButton(true)
            return
        }
        
        view?.enableCreateButton(false)
    }
    
    func confirmPasswordUpdated(_ value: String?) {
        
        self.password2 = value
        
        guard let password2 = self.password2 else {
            view?.enableCreateButton(false)
            return
        }
        
        if let password1 = password1 {
            passwordsAreIdentical = password1.compare(password2) == .orderedSame
        } else {
            passwordsAreIdentical = false
        }
        
        let validator = self.passwordValidator ?? PasswordValidator()
        password2Validated = validator.validate(password2)
        
        if userNameValidated == false {
            view?.enableCreateButton(false)
            return
        }
        
        if password1Validated == true &&
            password2Validated == true &&
            passwordsAreIdentical == true &&
            userNameValidated == true &&
            emailAddressValidated == true {
            
            view?.enableCreateButton(true)
            return
        }
        
        view?.enableCreateButton(false)
    }
    
    func signup(userName: String?, password: String?, emailAddress: String?) {
        
        let controller = self.signupController ?? SignupController(delegate: self)
        
        if let userName = userName,
            let password = password,
            let emailAddress = emailAddress,
            let model = SignupModel(userName: userName, password: password, emailAddress: emailAddress) {
            controller.doSignup(model: model)
        }
    }
    
    func openMain() {
        router?.close()
        router?.openMain()
    }
}

extension SignupViewModel: SignupControllerDelegate {
    
    func signupResult(result: Bool, error: String?) {
        // do someting with the result,
        // perhaps segue to a different screen of the app.
        
        // we show an alert as a dummy implementation
        view?.showSignupResult(result, error: error)
        
        
    }
    
}
