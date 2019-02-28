//
//  RecipesCoordinator.swift
//  TestRecipes
//
//  Created by Ginés Sánchez on 2019-02-26.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import UIKit

protocol RecipesCoordinatorType: Coordinating {
    var navigationController: UINavigationController? { get set }
}

final class RecipesCoordinator: RecipesCoordinatorType {
    let appContext: AppContextType
    let coordinatorFactory: CoordinatorFactoryType
    let viewControllerFactory: ViewControllerFactoryType
    var navigationController: UINavigationController?

    var recipeListViewController: RecipeListViewController?
    var recipeDetailViewController: RecipeDetailViewController?

    init(appContext: AppContextType, navigationController: UINavigationController) {
        self.appContext = appContext
        self.coordinatorFactory = appContext.coordinatorFactory
        self.viewControllerFactory = appContext.viewControllerFactory
        self.navigationController = navigationController
    }

    func start() {
        recipeListViewController = viewControllerFactory.makeRecipeListView(appContext: appContext, delegate: self)
        navigationController?.pushViewController(recipeListViewController!, animated: true)
    }

    func stop() {
        navigationController?.popViewController(animated: false)
        recipeListViewController = nil
    }
}

extension RecipesCoordinator: RecipeListViewControllerDelegate {

    func didSelect(recipe: RecipeSearchResult) {

        recipeDetailViewController = viewControllerFactory.makeRecipeDetailView(recipeId: recipe.recipeId, appContext: appContext, delegate: self)
        navigationController?.pushViewController(recipeDetailViewController!, animated: true)
    }
}

extension RecipesCoordinator: RecipeDetailViewControllerDelegate {

    func openWebView(url: URL) {
        print(url)
        //TODO: Open web view controller with url
    }
}
