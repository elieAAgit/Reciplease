//
//  ApiServiceTests.swift
//  RecipleaseTests
//
//  Created by Elie Arquier on 14/02/2021.
//  Copyright © 2021 Elie Arquier. All rights reserved.
//

/*@testable import Reciplease
import XCTest

class ApiServiceTests: XCTestCase {

    // MARK: - Properties
    
    var edamanParameters: [String]!
    
    // MARK: - Tests Life Cycle
    
    override func setUp() {
        super.setUp()
        edamanParameters = ["kiwi"]
    }

    func testGetData_WhenNoDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = ApiSessionFake(fakeResponse: FakeResponse(response: nil, data: nil))
        
        let apiService = ApiService(recipeRequest: session as RecipeRequest)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        apiService.getRecipe(url: ApiUrl.edamanUrl) { (success, response) in
            if success {
                guard response != nil else { return }

                XCTFail("Test with no data failed.")

            }

            XCTAssertNotNil(!success)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetData_WhenIncorrectResponseIsPassed_ThenShouldReturnFailedCallback() {
        let session = ApiSessionFake(fakeResponse: FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData))
        
        let apiService = ApiService(recipeRequest: session as RecipeRequest)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        apiService.getRecipe(url: ApiUrl.edamanUrl) { (success, response) in
            if success {
                guard response != nil else { return }

                XCTFail("Test with no data failed.")

            }

            XCTAssertNotNil(!success)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetData_WhenUndecodableDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = ApiSessionFake(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData))

        let apiService = ApiService(recipeRequest: session as RecipeRequest)
    
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        apiService.getRecipe(url: ApiUrl.edamanUrl) { (success, response) in
            if success {
                guard response != nil else { return }

                XCTFail("Test with no data failed.")

            }

            XCTAssertNotNil(!success)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetData_WhenCorrectDataIsPassed_ThenShouldReturnSuccededCallback() {
        let session = ApiSessionFake(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData))
        
        let apiService = ApiService(recipeRequest: session as RecipeRequest)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        apiService.getRecipe(url: ApiUrl.edamanUrl) { (success, response) in
            if success {
                guard response != nil else { return }

                XCTFail("Test with no data failed.")

            }
            
            XCTAssertTrue(response!.hits[0].recipe.label  == "Frozen Grapes and Kiwi")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
*/
