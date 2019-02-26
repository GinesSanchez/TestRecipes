//
//  RecipeManagerType.swift
//  TestRecipes
//
//  Created by Ginés Sánchez on 2019-02-26.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import Foundation

protocol RecipeManagerType {

    //TODO: Add documentation code
    //TODO: Set the correct parameters for the completion handler
    func getRecipes(filter: String?, completionHandler: @escaping ([String: Any]?, Error?) -> Void)
}
