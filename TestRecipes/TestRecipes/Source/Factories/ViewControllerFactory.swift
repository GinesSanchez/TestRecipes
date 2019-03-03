//
//  ViewControllerFactory.swift
//  test-weather
//
//  Created by Ginés Sánchez on 2019-02-18.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import Foundation

protocol ViewControllerFactoryType {

    func makeRecipeListView(appContext: AppContextType, delegate: RecipeListViewControllerDelegate) -> RecipeListViewController

    func makeRecipeDetailView(recipeId: String, appContext: AppContextType, delegate: RecipeDetailViewControllerDelegate) -> RecipeDetailViewController

    func makeWebView(url: URL, delegate: WebViewControllerDelegate) -> WebViewController
}

final class ViewControllerFactory: ViewControllerFactoryType {
    
    func makeRecipeListView(appContext: AppContextType, delegate: RecipeListViewControllerDelegate) -> RecipeListViewController {
        let recipeListVC = RecipeListViewController()
        recipeListVC.appContext = appContext
        recipeListVC.delegate = delegate
        return recipeListVC
    }

    func makeRecipeDetailView(recipeId: String, appContext: AppContextType, delegate: RecipeDetailViewControllerDelegate) -> RecipeDetailViewController {
        let recipeDetailVC = RecipeDetailViewController()
        recipeDetailVC.recipeId = recipeId
        recipeDetailVC.appContext = appContext
        recipeDetailVC.delegate = delegate
        return recipeDetailVC
    }

    func makeWebView(url: URL, delegate: WebViewControllerDelegate) -> WebViewController {
        let webVC = WebViewController()
        webVC.url = url
        webVC.delegate = delegate
        return webVC
    }
}
