//
//  ViewControllerFactory.swift
//  test-weather
//
//  Created by Ginés Sánchez on 2019-02-18.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import Foundation

final class ViewControllerFactory: ViewControllerFactoryType {
    
    func makeRecipeListView(appContext: AppContextType, delegate: RecipeListViewControllerDelegate) -> RecipeListViewController {
        let recipeListVC = RecipeListViewController()
        recipeListVC.appContext = appContext
        recipeListVC.delegate = delegate
        return recipeListVC
    }

    func makeRecipeDetailView(recipe: RecipeSearchResult, appContext: AppContextType, delegate: RecipeDetailViewControllerDelegate) -> RecipeDetailViewController {
        let recipeDetailVC = RecipeDetailViewController()
        recipeDetailVC.recipe = recipe
        recipeDetailVC.appContext = appContext
        recipeDetailVC.delegate = delegate
        return recipeDetailVC
    }
}
