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

    override func setUp() {
        fakeNavigationController = UINavigationController()
        fakeAppContext = FakeAppContextType()
        fakeRecipeListViewModelDelegate = FakeRecipeListViewModelDelegate()
        fakeRecipeDetailViewModelDelegate = FakeRecipeDetailViewModelDelegate()
    }
}
