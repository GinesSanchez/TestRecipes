//
//  RecipesCoordinator.swift
//  TestRecipes
//
//  Created by Ginés Sánchez on 2019-02-26.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import Foundation
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

    init(appContext: AppContextType, navigationController: UINavigationController) {
        self.appContext = appContext
        self.coordinatorFactory = appContext.coordinatorFactory
        self.viewControllerFactory = appContext.viewControllerFactory
        self.navigationController = navigationController
    }

    func start() {
        recipeListViewController = viewControllerFactory.makeRecipeListView()
        navigationController?.pushViewController(recipeListViewController!, animated: true)
    }

    func stop() {
        navigationController?.popViewController(animated: false)
        recipeListViewController = nil
    }
}
