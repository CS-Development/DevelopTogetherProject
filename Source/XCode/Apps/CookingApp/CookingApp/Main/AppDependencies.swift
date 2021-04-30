//
//  AppDependencies.swift
//  CookingApp
//
//  Created by Christian Slanzi on 27.04.21.
//

import UIKit
import LoginSignupModule
import NetworkingService
import CookingApiService

enum Tabs {
    case main
    case search

    var index: Int {
        switch self {
        case .main:
            return 0
        case .search:
            return 1
        }
    }

    var item: UITabBarItem {
        switch self {
        case .main:
            return UITabBarItem(title: "Home", image: nil, tag: index)
        case .search:
            return UITabBarItem(title: "Wishlist", image: nil, tag: index)
        }
    }
}

class AppDependencies {
    
    static let shared = AppDependencies()
    

    private var window: UIWindow?

    private init() {
        configureDependencies()
    }
    
    private func configureDependencies() {
        
    }
    
    internal func setRootViewController(_ viewController: UIViewController, window: UIWindow?) {
        window?.rootViewController = viewController
    }

    public func setScene(_ scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        window?.makeKeyAndVisible()
    }
    
    public func getWindow() -> UIWindow? {
        return window
    }

}

extension AppDependencies {
    
    func makeMainTab() -> UIViewController {
        let navigation = UINavigationController(rootViewController: createMainViewController())
        navigation.tabBarItem = Tabs.main.item
        return navigation
    }
    
    func makeSearchTab() -> UIViewController {
        let navigation = UINavigationController(rootViewController: createSignupViewController())
        navigation.tabBarItem = Tabs.search.item
        return navigation
    }
    
    internal func createMainTabBarController() -> UIViewController {
        let tabs = [makeMainTab(), makeSearchTab()]
        let tabController = MainTabBarController(viewControllers: tabs)
        return tabController
    }
    
    internal func createMainViewController() -> UIViewController {
        let viewController = ViewController()
        let networkingService = URLSessionHTTPClient(session: URLSession(configuration: .default))
        let serviceFactory = CookingApiServiceFactory(url: URL(string: "https://api.spoonacular.com")!,
                                                      client: networkingService,
                                                      apiKey: "COOKING_API_KEY")
        let service = serviceFactory.getCookingApiService()
        viewController.cookingApiService = service
        return viewController
    }
    
    private func createLoginViewController() -> LoginViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        let viewModel = LoginViewModel(view: controller)
        
        let loginController = LoginController(delegate: viewModel)
        let userApiService = LoginSignupWrapper()
        loginController.userApiService = userApiService
        viewModel.loginController = loginController
        
        controller.viewModel = viewModel
        controller.routing = self
        
        return controller
    }
    
    internal func createSignupViewController() -> SignupViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController

        let viewModel = SignupViewModel(view: controller)
        
        let signupController = SignupController(delegate: viewModel)
        let userApiService = LoginSignupWrapper()
        signupController.userApiService = userApiService
        viewModel.signupController = signupController
        
        controller.viewModel = viewModel
        controller.routing = self
        
        return controller
    }
}

extension AppDependencies {
    
    public func start() {
        login()
    }
    
    public func login() {
        var isUserLoggedIn = true
        
        //if we have credentials
        if isUserLoggedIn {
            routeToMainViewController()
        } else {
            setRootViewController(createLoginViewController(), window: window)
        }
    }
    
    public func logout() {
        //remove credentials
    
        //call login
        setRootViewController(createLoginViewController(), window: window)
    }
}
