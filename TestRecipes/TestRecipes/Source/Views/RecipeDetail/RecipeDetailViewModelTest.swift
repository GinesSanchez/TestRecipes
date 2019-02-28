//
//  RecipeDetailViewModelTest.swift
//  TestRecipesTests
//
//  Created by Ginés Sánchez on 2019-02-28.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import XCTest
@testable import TestRecipes

class RecipeDetailViewModelTest: TestCaseBase {

    var recipeDetailViewModel: RecipeDetailViewModel?

    override func setUp() {
        super.setUp()

        recipeDetailViewModel = RecipeDetailViewModel(recipeId: "", delegate: fakeRecipeDetailViewModelDelegate, appContext: fakeAppContext)
    }

    func testInit_whenFreshlyInitialised_shouldNotHaveCalledStateDidChange() {
        XCTAssertFalse(fakeRecipeDetailViewModelDelegate.didStateDidChangeCalled)
    }

    func testUpdate_whenStateChange_shouldHaveCalledStateDidChange() {
        recipeDetailViewModel?.viewModelState = .loading
        DispatchQueue.main.async { [weak self] in
            XCTAssert(self?.fakeRecipeDetailViewModelDelegate.didStateDidChangeCalled ?? false)
        }
    }

}
