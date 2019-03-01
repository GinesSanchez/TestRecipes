//
//  FakeConstants.swift
//  TestRecipesTests
//
//  Created by Ginés Sánchez on 2019-03-01.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import Foundation

enum FakeConstants {

    enum RecipeAPIDetails {
        static let apiScheme: String = "https"
        static let apiHost: String = "www.food2fork.com"
        static let apiGetPath: String = "/api/get"
        static let apiSearchPath: String = "/api/search"
        static let apiKey: String = "key"
        static let searchQueryKey: String = "q"
        static let recipeIdKey: String = "rId"
        static let apiKeyValue: String = "c03f1fe8a8c1f9ef7f50fc52eccbe70c"
        static let originaRecipeUrl: String = "https://www.allrecipes.com/recipe/89539/slow-cooker-chicken-tortilla-soup/"
    }

    enum Recipe {
        static let recipeId: String = "29159"
        static let title: String = "Slow Cooker Chicken Tortilla Soup"
        static let imageUrl: String = "http://static.food2fork.com/19321150c4.jpg"
        static let ingredients: [String] = ["1 pound shredded, cooked chicken",
                                            "1 (15 ounce) can whole peeled tomatoes, mashed",
                                            "1 (10 ounce) can enchilada sauce",
                                            "1 medium onion, chopped",
                                            "1 (4 ounce) can chopped green chile peppers"]
        static let publisher: String = "All Recipes"
        static let socialRank: String = "100"
        static let instructionsUrl: String = "http://allrecipes.com/Recipe/Slow-Cooker-Chicken-Tortilla-Soup/Detail.aspx"
        static let originalUrl: String = "http://food2fork.com/view/29159"
    }

    enum RecipeSearchResult {
        static let recipeId: String = "29159"
        static let title: String = "Slow Cooker Chicken Tortilla Soup"
        static let imageUrl: String = "http://static.food2fork.com/19321150c4.jpg"
    }
}
