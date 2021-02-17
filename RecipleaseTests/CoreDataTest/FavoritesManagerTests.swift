//
//  FavoritesManagerTests.swift
//  RecipleaseTests
//
//  Created by Elie Arquier on 17/02/2021.
//  Copyright © 2021 Elie Arquier. All rights reserved.
//

import XCTest
@testable import Reciplease

final class FavoritesManagerTests: XCTestCase {
    
    // MARK: - Properties

    var coreDataStack: MockCoreDataStack!
    var favoritesManager: FavoritesManager!

    // Frozen Grapes and Kiwi
    var image  = "https://www.edamam.com/web-img/eed/eed6cb4bd6313cacc691862d0e014892.jpg"
    var label = "Frozen Grapes and Kiwi"
    var yield = "2.0"
    var totalTime = 0.0
    var ingredientLines = "ingredientLines"
    var url = "https://www.marthastewart.com/1050596/frozen-grapes-and-kiwi"

    // MARK: - Tests Life Cycle

    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack(name: "Reciplease")
        favoritesManager = FavoritesManager(context: coreDataStack.viewContext)
    }

    override func tearDown() {
        super.tearDown()
        favoritesManager = nil
        coreDataStack = nil
    }

    // MARK: - Tests

    func testAddRecipe_WhenARecipeIsCreated_ThenShouldBeCorrectlySaved() {
        
        // Add 1 recipe in favorite
        favoritesManager.addRecipe(image: image, label: label, yield: yield, totalTime: totalTime, ingredientLines: ingredientLines, url: url)

        XCTAssertTrue(!favoritesManager.fetchedResultsController.isEmpty)
        XCTAssertEqual(favoritesManager.fetchedResultsController.count, 1)
        XCTAssertTrue(favoritesManager.fetchedResultsController[0].label == label)
        XCTAssertTrue(favoritesManager.fetchedResultsController[0].ingredientLines == ingredientLines)
        XCTAssertTrue(favoritesManager.fetchedResultsController[0].yield == yield)
        XCTAssertTrue(favoritesManager.fetchedResultsController[0].totalTime == totalTime)
        XCTAssertTrue(favoritesManager.fetchedResultsController[0].image == image)
        XCTAssertTrue(favoritesManager.fetchedResultsController[0].url == url)

        favoritesManager.recipeIsFavoriteOrNot(title: label) { (favorite) in
            XCTAssertTrue(favorite)
        }

        XCTAssertTrue(favoritesManager.fetchedResultsController.count > 0)
    }

    func testDeleteRecipe_WhenARecipeIsCreated_ThenShouldBeCorrectlyDeleted() {

        // Add 1 recipe in favorite
        favoritesManager.addRecipe(image: image, label: label, yield: yield, totalTime: totalTime, ingredientLines: ingredientLines, url: url)

        // Verification of the addition of the recipe into the favorites
        XCTAssertEqual(favoritesManager.fetchedResultsController.count, 1)
        XCTAssertTrue(favoritesManager.fetchedResultsController[0].label == label)
 
        // Suppression of the recipe
        favoritesManager.suppressRecipe(title: label)
        
        favoritesManager.recipeIsFavoriteOrNot(title: label) { (favorite) in
            XCTAssertFalse(favorite)
        }

        XCTAssertTrue(favoritesManager.fetchedResultsController.isEmpty)
        
    }
}
