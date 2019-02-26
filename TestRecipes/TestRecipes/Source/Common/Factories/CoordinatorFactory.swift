//
//  CoordinatorFactory.swift
//  test-weather
//
//  Created by Ginés Sánchez on 2019-02-18.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import Foundation
import UIKit

final class CoordinatorFactory: CoordinatorFactoryType {

    func makeAppCoordinator(appContext: AppContextType, navigationController: UINavigationController) -> AppCoordinatorType {
        return AppCoordinator(appContext: appContext, navigationController: navigationController)
    }

    func makeRecipesCoordinator(appContext: AppContextType, navigationController: UINavigationController) -> RecipesCoordinatorType {
        return RecipesCoordinator(appContext: appContext, navigationController: navigationController)
    }
}
