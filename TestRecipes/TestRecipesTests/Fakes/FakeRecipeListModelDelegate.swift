//
//  FakeRecipeListModelDelegate.swift
//  TestRecipesTests
//
//  Created by Ginés Sánchez on 2019-02-28.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import Foundation
@testable import TestRecipes

final class FakeRecipeListViewModelDelegate: RecipeListViewModelDelegate {

    //MARK: - stateDidChange

    var didStateDidChangeCalled = false

    func viewModel(_ viewModel: RecipeListViewModel, stateDidChange state: ViewModelState<RecipeListReadyState>) {
        didStateDidChangeCalled = true
    }
}
