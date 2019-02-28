//
//  RecipeListViewModelTest.swift
//  TestRecipesTests
//
//  Created by Ginés Sánchez on 2019-02-28.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import XCTest
@testable import TestRecipes

class RecipeListViewModelTest: TestCaseBase {

    var recipeListViewModel: RecipeListViewModel?

    override func setUp() {
        super.setUp()

        recipeListViewModel = RecipeListViewModel(delegate: fakeRecipeListViewModelDelegate, appContext: fakeAppContext)
    }

    func testInit_whenFreshlyInitialised_shouldNotHaveCalledStateDidChange() {
        XCTAssertFalse(fakeRecipeListViewModelDelegate.didStateDidChangeCalled)
    }

    func testUpdate_whenStateChange_shouldHaveCalledStateDidChange() {
        recipeListViewModel?.viewModelState = .loading
        DispatchQueue.main.async { [weak self] in
            XCTAssert(self?.fakeRecipeListViewModelDelegate.didStateDidChangeCalled ?? false)
        }
    }
}
