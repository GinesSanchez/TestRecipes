//
//  TestCaseBase.swift
//  TestRecipesTests
//
//  Created by Ginés Sánchez on 2019-02-28.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import XCTest

@testable import TestRecipes

class TestCaseBase: XCTestCase {

    var fakeAppContext: FakeAppContextType!
    var fakeNavigationController: UINavigationController!
    var fakeRecipeListViewModelDelegate: FakeRecipeListViewModelDelegate!
    var fakeRecipeDetailViewModelDelegate: FakeRecipeDetailViewModelDelegate!
    var fakeOriginalUrl: URL!
    var fakeRecipe: Recipe!
    var fakeRecipeSearchResult: RecipeSearchResult!

    override func setUp() {
        fakeNavigationController = UINavigationController()
        fakeAppContext = FakeAppContextType()
        fakeRecipeListViewModelDelegate = FakeRecipeListViewModelDelegate()
        fakeRecipeDetailViewModelDelegate = FakeRecipeDetailViewModelDelegate()

        fakeOriginalUrl = URL(unsecureUrlString: FakeConstants.RecipeAPIDetails.originaRecipeUrl)

        fakeRecipe = Recipe(recipeId: FakeConstants.Recipe.recipeId,
                            title: FakeConstants.Recipe.title,
                            imageUrl: FakeConstants.Recipe.imageUrl,
                            ingredients: FakeConstants.Recipe.ingredients,
                            publisher: FakeConstants.Recipe.publisher,
                            socialRank: FakeConstants.Recipe.socialRank,
                            instructionsUrl: FakeConstants.Recipe.instructionsUrl,
                            originalUrl: FakeConstants.Recipe.originalUrl)

        fakeRecipeSearchResult = RecipeSearchResult(recipeId: FakeConstants.RecipeSearchResult.recipeId,
                                                    title: FakeConstants.RecipeSearchResult.title,
                                                    imageUrl: FakeConstants.RecipeSearchResult.imageUrl)

    }
}
