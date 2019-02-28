//
//  RecipeDetailViewController.swift
//  TestRecipes
//
//  Created by Ginés Sánchez on 2019-02-28.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import UIKit

protocol RecipeDetailViewControllerDelegate: class {
    //TODO:
}

final class RecipeDetailViewController: UIViewController {

    //Public Properties
    weak var delegate: RecipeDetailViewControllerDelegate?
    var appContext: AppContextType!
    var recipe: RecipeSearchResult!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(recipe)
    }
}
