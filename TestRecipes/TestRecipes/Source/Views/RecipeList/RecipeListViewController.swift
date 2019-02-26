//
//  RecipeListViewController.swift
//  TestRecipes
//
//  Created by Ginés Sánchez on 2019-02-26.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import UIKit

protocol RecipeListViewControllerDelegate: class {
    //TODO:
}

final class RecipeListViewController: UIViewController {

    //Public Properties
    weak var delegate: RecipeListViewControllerDelegate?
    var appContext: AppContextType!

    //Private Properties
    private var recipeListViewModel: RecipeListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
    }
}

// MARK: - Set Up Methods
private extension RecipeListViewController {

    func setUp() {
        setUpViewModel()
        //TODO: Add UI set up
    }

    func setUpViewModel() {
        recipeListViewModel = RecipeListViewModel(delegate: self, appContext: appContext)
    }
}

extension RecipeListViewController: RecipeListViewModelDelegate {
    //TODO:
}
