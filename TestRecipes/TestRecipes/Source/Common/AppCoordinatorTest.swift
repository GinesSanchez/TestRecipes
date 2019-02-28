//
//  AppCoordinatorTest.swift
//  TestRecipesTests
//
//  Created by Ginés Sánchez on 2019-02-28.
//  Copyright © 2019 Ginés Sánchez. All rights reserved.
//

import XCTest
@testable import TestRecipes

class AppCoordinatorTest: TestCaseBase {

    var appCoordinator: AppCoordinator?

    override func setUp() {
        super.setUp()

        appCoordinator = AppCoordinator(appContext: fakeAppContext, navigationController: fakeNavigationController)
    }

    func testInit_whenFreshlyInitialised_shouldNotHaveViewController() {
        let weatherViewCoordinator = appCoordinator?.recipesCoordinator

        XCTAssertNil(weatherViewCoordinator, "we should lazily load the coordinator on start")
    }

    func testStart_whenInvoked_shouldReplaceCoordinator() {
        appCoordinator?.start()

        XCTAssertNotNil(appCoordinator?.recipesCoordinator, "The coordinator should be not nil")
    }

    func testStop_whenInvoked_shouldNilOutCoordinator() {
        appCoordinator?.start() // should create vc
        appCoordinator?.stop() //should deallocate the vc

        XCTAssertNil(appCoordinator?.recipesCoordinator)
    }
}
