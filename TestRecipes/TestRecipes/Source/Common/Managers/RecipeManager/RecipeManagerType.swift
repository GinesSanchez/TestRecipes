//
//  RecipeManagerType.swift
//  TestRecipes
//
//  Created by Ginés Sánchez on 2019-02-26.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import UIKit

protocol RecipeManagerType {

    /// Get list of recipes filtering by ingredient
    ///
    /// - Parameter
    ///     - ingredient: optional string with the name of one ingredient to filtering with.
    ///     - completionHandler: will be triggred when the request is done. If it is successfull, an array of Recipe Search Result is returned. Error will be nil if successful. If there is an error, a Recipe Manager Error is returned, and dictionary will be nil.
    func getRecipes(ingredient: String?, completionHandler: @escaping ([RecipeSearchResult]?, RecipeManagerError?) -> Void)

    /// Get image of recipe
    ///
    /// - Parameter
    ///     - urlString: string with the url of the image.
    ///     - completionHandler: will be triggred when the request is done. If it is successfull, an UIImage is returned. Error will be nil if successful. If there is an error, a Recipe Manager Error is returned, and dictionary will be nil
    func getRecipeImage(urlString: String, completionHandler: @escaping (UIImage?, RecipeManagerError?) -> Void)
}
