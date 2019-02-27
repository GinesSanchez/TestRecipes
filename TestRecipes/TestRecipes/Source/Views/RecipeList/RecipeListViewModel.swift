//
//  RecipeListViewModel.swift
//  TestRecipes
//
//  Created by Ginés Sánchez on 2019-02-26.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import Foundation

protocol RecipeListViewModelDelegate: class {
    //TODO:
}

final class RecipeListViewModel {

    private weak var delegate: RecipeListViewModelDelegate?
    private var appContext: AppContextType


    init(delegate: RecipeListViewModelDelegate, appContext: AppContextType) {
        self.delegate = delegate
        self.appContext = appContext

        //TODO: Remove sample code
        self.appContext.recipeManager.getRecipes(filter: "tomato") { (searchResultArray, error) in            

            print(searchResultArray)

            let recipe = searchResultArray?.first

            self.appContext.recipeManager.getRecipeImage(urlString: recipe!.imageUrl, completionHandler: { (image, error) in
                print(image)
            })
        }
    }
}
