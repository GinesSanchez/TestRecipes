//
//  FakeAppContextType.swift
//  TestRecipesTests
//
//  Created by Ginés Sánchez on 2019-02-28.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import Foundation

import UIKit

final class FakeAppContextType: AppContextType {

    var appCoordinator: AppCoordinatorType?
    var viewControllerFactory: ViewControllerFactoryType
    var coordinatorFactory: CoordinatorFactoryType
    var recipeManager: RecipeManagerType
    var networkManager: NetworkManagerType

    init() {
        self.coordinatorFactory = CoordinatorFactory()
        self.viewControllerFactory = ViewControllerFactory()
        self.networkManager = NetworkManager()
        self.recipeManager = RecipeManager(networkManager: self.networkManager)
        self.appCoordinator = coordinatorFactory.makeAppCoordinator(appContext: self,
                                                                    navigationController: UINavigationController())
    }
}
