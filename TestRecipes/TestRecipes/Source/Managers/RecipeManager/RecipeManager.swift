//
//  RecipeManager.swift
//  TestRecipes
//
//  Created by Ginés Sánchez on 2019-02-26.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import UIKit

import UIKit

protocol RecipeManagerType {

    /// Get list of recipes filtering by ingredient
    ///
    /// - Parameter
    ///     - ingredient: optional string with the name of one ingredient to filtering with.
    ///     - completionHandler: will be triggred when the request is done. If it is successfull, an array of Recipe Search Result is returned. Error will be nil if successful. If there is an error, a Recipe Manager Error is returned, and array will be nil.
    func getRecipes(ingredient: String?, completionHandler: @escaping ([RecipeSearchResult]?, RecipeManagerError?) -> Void)

    /// Get image of recipe
    ///
    /// - Parameter
    ///     - urlString: string with the url of the image.
    ///     - completionHandler: will be triggred when the request is done. If it is successfull, an UIImage is returned. Error will be nil if successful. If there is an error, a Recipe Manager Error is returned, and the image will be nil
    func getRecipeImage(urlString: String, completionHandler: @escaping (UIImage?, RecipeManagerError?) -> Void)

    /// Get recipe
    ///
    /// - Parameter
    ///     - id: string with the id of the recipe.
    ///     - completionHandler: will be triggred when the request is done. If it is successfull, an Recipe is returned. Error will be nil if successful. If there is an error, a Recipe Manager Error is returned, and recipe will be nil
    func getRecipe(id: String, completionHandler: @escaping (Recipe?, RecipeManagerError?) -> Void)
}


final class RecipeManager: RecipeManagerType {

    var networkManager: NetworkManagerType

    init(networkManager: NetworkManagerType) {
        self.networkManager = networkManager
    }

    func getRecipes(ingredient: String?, completionHandler: @escaping ([RecipeSearchResult]?, RecipeManagerError?) -> Void) {

        let url = networkManager.createURLWith(apiScheme: Constants.RecipeAPIDetails.apiScheme,
                                               apiHost: Constants.RecipeAPIDetails.apiHost,
                                               apiPath: Constants.RecipeAPIDetails.apiSearchPath,
                                               parameters: [Constants.RecipeAPIDetails.searchQueryKey : ingredient ?? "",
                                                            Constants.RecipeAPIDetails.apiKey: Constants.RecipeAPIDetails.apiKeyValue])

        networkManager.getJson(url: url) { (json, error) in
            guard let json = json else {
                guard let error = error else {
                    completionHandler(nil, .unknownError)
                    return
                }
                let errorCode = (error as NSError).code

                switch errorCode {
                case -1009:
                    completionHandler(nil, .noInternetConnection)
                    break
                case 3840:
                    //We always get this error for any api error: wrong key, wrong url...
                    completionHandler(nil, .unknownApiError)
                default:
                    completionHandler(nil, .unknownError)
                    break
                }

                return
            }

            if let jsonArray = json["recipes"] as? [[String: Any]] {
                var searchResultJson: [RecipeSearchResult] = []
                do {
                    searchResultJson = try Array(withJSONArray: jsonArray)
                } catch {
                    completionHandler(nil, .malformedRecipeSearchResultJson)
                }
                completionHandler(searchResultJson, nil)

            } else {
                completionHandler(nil, .malformedRecipeSearchResultJson)
            }
        }
    }

    func getRecipeImage(urlString: String, completionHandler: @escaping (UIImage?, RecipeManagerError?) -> Void) {        

        if let url = URL(unsecureUrlString: urlString) {
            networkManager.getImage(url: url) { (image, error) in
                guard let image = image else {                    
                    guard let error = error else {
                        completionHandler(nil, .unknownError)
                        return
                    }

                    let errorCode = (error as NSError).code

                    switch errorCode {
                    case -1009:
                        completionHandler(nil, .noInternetConnection)
                        break
                    default:
                        completionHandler(nil, .noDownloadedImage)
                        break
                    }

                    return
                }

                completionHandler(image, nil)
            }
        } else {
            completionHandler(nil, .malformedURL)
        }
    }

    func getRecipe(id: String, completionHandler: @escaping (Recipe?, RecipeManagerError?) -> Void) {

        let url = networkManager.createURLWith(apiScheme: Constants.RecipeAPIDetails.apiScheme,
                                               apiHost: Constants.RecipeAPIDetails.apiHost,
                                               apiPath: Constants.RecipeAPIDetails.apiGetPath,
                                               parameters: [Constants.RecipeAPIDetails.recipeIdKey : id,
                                                            Constants.RecipeAPIDetails.apiKey: Constants.RecipeAPIDetails.apiKeyValue])

        networkManager.getJson(url: url) { (json, error) in
            guard let json = json else {
                guard let error = error else {
                    completionHandler(nil, .unknownError)
                    return
                }
                let errorCode = (error as NSError).code

                switch errorCode {
                case -1009:
                    completionHandler(nil, .noInternetConnection)
                    break
                case 3840:
                    //We always get this error for any api error: wrong key, wrong url...
                    completionHandler(nil, .unknownApiError)
                default:
                    completionHandler(nil, .unknownError)
                    break
                }

                return
            }

            if let jsonRecipe = json["recipe"] as? [String: Any] {
                var recipe: Recipe? = nil
                do {
                    recipe = try Recipe(withJSON: jsonRecipe)
                } catch {
                    completionHandler(nil, .malformedRecipeSearchResultJson)
                }
                completionHandler(recipe, nil)

            } else {
                completionHandler(nil, .malformedRecipeSearchResultJson)
            }
        }
    }
}
