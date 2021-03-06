//
//  SearchRoute.swift
//  CookingApp
//
//  Created by Christian Slanzi on 31.05.21.
//

import Foundation
import RecipeFeature
import CommonRouting

protocol SearchRoute {
    func openRecipeList(_ recipes: [Recipe])
}

extension SearchRoute where Self: Router {

    func openRecipeList(_ recipes: [Recipe], with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewController = CookingAppDependencies.shared.createRecipeListViewController(title: "Recipes", recipes: recipes)
        router.root = viewController

        route(to: viewController, as: transition)
    }

    func openRecipeList(_ recipes: [Recipe]) {
        openRecipeList(recipes, with: PushTransition())
    }
}

extension DefaultRouter: SearchRoute {}
