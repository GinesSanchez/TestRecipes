//
//  ViewControllerFactoryType.swift
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
