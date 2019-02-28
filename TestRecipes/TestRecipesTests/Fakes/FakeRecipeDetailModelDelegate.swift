//
//  FakeRecipeDetailModelDelegate.swift
//  TestRecipesTests
//
//  Created by Ginés Sánchez on 2019-02-28.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import Foundation
@testable import TestRecipes

final class FakeRecipeDetailViewModelDelegate: RecipeDetailViewModelDelegate {

    //MARK: - stateDidChange

    var didStateDidChangeCalled = false

    func viewModel(_ viewModel: RecipeDetailViewModel, stateDidChange state: ViewModelState<RecipeDetailReadyState>) {
        didStateDidChangeCalled = true
    }
}
