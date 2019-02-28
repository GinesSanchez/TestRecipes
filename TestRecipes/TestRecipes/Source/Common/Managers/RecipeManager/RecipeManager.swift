//
//  RecipeManager.swift
//  TestRecipes
//
//  Created by Ginés Sánchez on 2019-02-26.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import UIKit

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
