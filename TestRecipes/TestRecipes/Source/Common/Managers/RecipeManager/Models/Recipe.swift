//
//  Recipe.swift
//  TestRecipes
//
//  Created by Ginés Sánchez on 2019-02-28.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import Foundation

private let recipeIdKey = "recipe_id"
private let titleKey = "title"
private let imageUrlKey = "image_url"
private let ingredientsKey = "ingredients"
private let publisherKey = "publisher"
private let socialRankKey = "social_rank"
private let instructionsUrlKey = "source_url"
private let originalUrlKey = "f2f_url"

public struct Recipe: JSONInitializable {

    public let recipeId: String
    public let title: String
    public let imageUrl: URL
    public let ingredients: [String]
    public let publisher: String
    public let socialRank: String
    public let instructionsUrl: URL
    public let originalUrl: URL

    public init(recipeId: String, title: String, imageUrl: URL, ingredients: [String], publisher: String, socialRank: String, instructionsUrl: URL, originalUrl: URL) {
        self.recipeId = recipeId
        self.title = title
        self.imageUrl = imageUrl
        self.ingredients = ingredients
        self.publisher = publisher
        self.socialRank = socialRank
        self.instructionsUrl = instructionsUrl
        self.originalUrl = originalUrl
    }

    public init(withJSON json: [String : Any]) throws {
        guard
            let recipeId = json[recipeIdKey] as? String,
            let title = json[titleKey] as? String,
            let imageUrlString = json[imageUrlKey] as? String,
            let ingredients = json[ingredientsKey] as? [String],
            let publisher = json[publisherKey] as? String,
            let socialRankInt = json[socialRankKey] as? Int,
            let instructionsUrlString = json[instructionsUrlKey] as? String,
            let originalUrlString = json[originalUrlKey] as? String,

            let imageUrl = URL(string: imageUrlString),
            let instructionsUrl = URL(string: instructionsUrlString),
            let originalUrl = URL(string: originalUrlString)
            else {
                throw RecipeManagerError.malformedRecipeSearchResultJson
        }

        let socialRank = String(socialRankInt)

        self = Recipe(recipeId: recipeId, title: title, imageUrl: imageUrl, ingredients: ingredients, publisher: publisher, socialRank: socialRank, instructionsUrl: instructionsUrl, originalUrl: originalUrl)
    }

    public var jsonRepresentation: [String: Any] {
        return [
            recipeIdKey: recipeId,
            titleKey: title,
            imageUrlKey: imageUrl,
            ingredientsKey: ingredients,
            publisherKey: publisher,
            socialRankKey: socialRank,
            instructionsUrlKey: instructionsUrl,
            originalUrlKey: originalUrl
        ]
    }
}

extension Recipe: Equatable {}

extension Array where Element == Recipe {

    public init(withJSONArray jsonArray: [[String: Any]]) throws {
        var recipes: [Recipe] = []
        for recipeJSON in jsonArray {
            recipes.append(try Recipe(withJSON: recipeJSON))
        }
        self = recipes
    }
}
