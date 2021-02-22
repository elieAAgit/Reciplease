//
//  ApiServiceTests.swift
//  RecipleaseTests
//
//  Created by Elie Arquier on 14/02/2021.
//  Copyright © 2021 Elie Arquier. All rights reserved.
//

@testable import Reciplease
import XCTest

class ApiServiceTests: XCTestCase {

    // MARK: - Properties
    
    var edamanParameters: [String]!
    
    // MARK: - Tests Life Cycle
    
    override func setUp() {
        super.setUp()
        edamanParameters = ["kiwi"]
    }

    // MARK: - Tests

    func testGetRecipe_WhenNoDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = ApiSessionFake(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: nil))
        
        let apiService = ApiService(recipeRequest: session as RecipeRequest)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        apiService.getRecipe(url: ApiUrl.edamanUrl) { (success, response) in

            XCTAssertFalse(success)
            XCTAssertNil(response)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipe_WhenIncorrectResponseIsPassed_ThenShouldReturnFailedCallback() {
        let session = ApiSessionFake(fakeResponse: FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData))
        
        let apiService = ApiService(recipeRequest: session as RecipeRequest)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        apiService.getRecipe(url: ApiUrl.edamanUrl) { (success, response) in

            XCTAssertFalse(success)
            XCTAssertNil(response)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipe_WhenIncorrectDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = ApiSessionFake(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData))

        let apiService = ApiService(recipeRequest: session as RecipeRequest)
    
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        apiService.getRecipe(url: ApiUrl.edamanUrl) { (success, response) in

            XCTAssertFalse(success)
            XCTAssertNil(response)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipe_WhenCorrectDataIsPassed_ThenShouldReturnSuccededCallback() {
        let session = ApiSessionFake(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData))
        
        let apiService = ApiService(recipeRequest: session as RecipeRequest)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        apiService.getRecipe(url: ApiUrl.edamanUrl) { (success, response) in

            XCTAssertTrue(success)
            XCTAssertEqual(response!.hits[0].recipe.label, "Frozen Grapes and Kiwi")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
