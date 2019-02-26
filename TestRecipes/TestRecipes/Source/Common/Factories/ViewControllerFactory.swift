//
//  ViewControllerFactory.swift
//  test-weather
//
//  Created by Ginés Sánchez on 2019-02-18.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import Foundation

final class ViewControllerFactory: ViewControllerFactoryType {
    
    func makeRecipeListView() -> RecipeListViewController {
        let weatherVC = RecipeListViewController()
        return weatherVC
    }
}
