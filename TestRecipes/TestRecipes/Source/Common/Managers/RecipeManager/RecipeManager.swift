//
//  RecipeManager.swift
//  TestRecipes
//
//  Created by Ginés Sánchez on 2019-02-26.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import Foundation

final class RecipeManager: RecipeManagerType {

    var networkManager: NetworkManagerType

    init(networkManager: NetworkManagerType) {
        self.networkManager = networkManager
    }

    func getRecipes(filter: String?, completionHandler: @escaping ([String: Any]?, Error?) -> Void) {

        let url = networkManager.createURLWith(apiScheme: Constants.RecipeAPIDetails.apiScheme,
                                               apiHost: Constants.RecipeAPIDetails.apiHost,
                                               apiPath: Constants.RecipeAPIDetails.apiSearchPath,
                                               parameters: [Constants.RecipeAPIDetails.searchQueryKey : filter ?? "",
                                                            Constants.RecipeAPIDetails.apiKey: Constants.RecipeAPIDetails.apiKeyValue])

        networkManager.getJson(with: url) { (json, error) in
            guard let json = json else {
                //TODO:
                return
            }

            print(json)
            //TODO:
            completionHandler(nil, nil)
        }
    }
}
