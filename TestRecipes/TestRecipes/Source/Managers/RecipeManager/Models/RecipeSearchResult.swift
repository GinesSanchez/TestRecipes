//
//  Recipe.swift
//  TestRecipes
//
//  Created by Ginés Sánchez on 2019-02-27.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import Foundation

private let recipeIdKey = "recipe_id"
private let titleKey = "title"
private let imageUrlKey = "image_url"

public struct RecipeSearchResult: JSONInitializable {

    public let recipeId: String
    public let title: String
    public let imageUrl: String

    public init(recipeId: String, title: String, imageUrl: String) {
        self.recipeId = recipeId
        self.title = title
        self.imageUrl = imageUrl
    }

    public init(withJSON json: [String : Any]) throws {
        guard
            let recipeId = json[recipeIdKey] as? String,
            let title = json[titleKey] as? String,
            let imageUrl = json[imageUrlKey] as? String
            else {
                throw RecipeManagerError.malformedRecipeSearchResultJson
        }
        self = RecipeSearchResult(recipeId: recipeId, title: title, imageUrl: imageUrl)
    }

    public var jsonRepresentation: [String: Any] {
        return [
            recipeIdKey: recipeId,
            titleKey: title,
            imageUrlKey: imageUrl
        ]
    }
}

extension RecipeSearchResult: Equatable {}

extension Array where Element == RecipeSearchResult {

    public init(withJSONArray jsonArray: [[String: Any]]) throws {
        var recipes: [RecipeSearchResult] = []
        for recipeJSON in jsonArray {
            recipes.append(try RecipeSearchResult(withJSON: recipeJSON))
        }
        self = recipes
    }
}
