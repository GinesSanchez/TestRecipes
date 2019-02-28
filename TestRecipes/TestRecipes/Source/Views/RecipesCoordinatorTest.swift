//
//  RecipesCoordinatorTest.swift
//  TestRecipesTests
//
//  Created by Ginés Sánchez on 2019-02-28.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import XCTest
@testable import TestRecipes

class RecipesCoordinatorTest: TestCaseBase {

    var recipesCoordinator: RecipesCoordinator?

    override func setUp() {
        super.setUp()

        recipesCoordinator = RecipesCoordinator(appContext: fakeAppContext, navigationController: fakeNavigationController)
    }

    func testInit_whenFreshlyInitialised_shouldNotHaveViewController() {
        let viewController = recipesCoordinator?.recipeListViewController

        XCTAssertNil(viewController, "we should lazily load the view controller on start")
    }

    func testStart_whenInvoked_shouldReplaceViewController() {
        recipesCoordinator?.start()

        if let numberOfViewControllersOnNavigationController = fakeNavigationController?.viewControllers.count {
            XCTAssert(numberOfViewControllersOnNavigationController == 1, "Number of controllers should be 1")
        } else {
            XCTAssert(false, "view controllers property has not been set on navigation controller")
        }
    }

    func testStart_whenInvoked_shouldReplaceViewControllerOnNavigationControllerWithWeatherViewController() {
        recipesCoordinator?.start()

        let firstViewController = fakeNavigationController?.viewControllers[0]
        XCTAssert(firstViewController is RecipeListViewController)
    }

    func testStop_whenInvoked_shouldNilOutViewController() {
        recipesCoordinator?.start() // should create vc
        recipesCoordinator?.stop() //should deallocate the vc

        XCTAssert(recipesCoordinator?.recipeListViewController == nil)
    }
}
