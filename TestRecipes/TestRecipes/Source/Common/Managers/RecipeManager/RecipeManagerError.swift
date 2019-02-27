//
//  RecipeManagerError.swift
//  TestRecipes
//
//  Created by Ginés Sánchez on 2019-02-27.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import Foundation

public enum RecipeManagerError: Error {

    case malformedRecipeSearchResultJson
    case noInternetConnection
    case unknownApiError
    case unknownError
    case malformedURL
    case noDownloadedImage

    /// descriptive representation of error, should be used for debugging
    public var description: String {
        switch self {
        case .malformedRecipeSearchResultJson:
            return "Malformed Recipe Search Result Json."
        case .noInternetConnection:
            return "There is not internet connection."
        case .unknownApiError:
            return "Unknown Api Error."
        case .unknownError:
            return "Uknown Error from the request."
        case .malformedURL:
            return "Malformed Request Url."
        case .noDownloadedImage:
            return "There were problems downloading the image."
        }        
    }
}
