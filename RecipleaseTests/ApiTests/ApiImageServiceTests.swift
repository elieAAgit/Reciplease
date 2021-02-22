//
//  ApiImageServiceTests.swift
//  RecipleaseTests
//
//  Created by Elie Arquier on 21/02/2021.
//  Copyright © 2021 Elie Arquier. All rights reserved.
//

@testable import Reciplease
import XCTest

class ApiImageServiceTests: XCTestCase {

    // MARK: - Properties
    
    var imageUrl: String!
    
    // MARK: - Tests Life Cycle
    
    override func setUp() {
        super.setUp()
        imageUrl = "https://www.edamam.com/web-img/eed/eed6cb4bd6313cacc691862d0e014892.jpg"
    }

    // MARK: - Tests

    func testGetImage_WhenNoDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = ApiImageSessionFake(fakeResponse: FakeResponse(response: FakeResponseDataImage.responseOK, data: nil))
        
        let apiService = ApiImageService(imageRequest: session as ImageRequest)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        apiService.getImage(imageUrl: imageUrl ) { (success, data) in

            XCTAssertFalse(success)
            XCTAssertNil(data)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetImage_WhenIncorrectResponseIsPassed_ThenShouldReturnFailedCallback() {
        let session = ApiImageSessionFake(fakeResponse: FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseDataImage.correctData))
        
        let apiService = ApiImageService(imageRequest: session as ImageRequest)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        apiService.getImage(imageUrl: imageUrl ) { (success, data) in
            
            XCTAssertFalse(success)
            XCTAssertNil(data)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetImage_WhenIncorrectDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = ApiImageSessionFake(fakeResponse: FakeResponse(response: FakeResponseDataImage.responseOK, data: FakeResponseDataImage.incorrectData))
        
        let apiService = ApiImageService(imageRequest: session as ImageRequest)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        apiService.getImage(imageUrl: imageUrl ) { (success, data) in

            XCTAssertFalse(success)
            XCTAssertNil(data)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetImage_WhenCorrectDataIsPassed_ThenShouldReturnSuccededCallback() {

        let session = ApiImageSessionFake(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseDataImage.correctData))
        
        let apiService = ApiImageService(imageRequest: session as ImageRequest)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        apiService.getImage(imageUrl: imageUrl ) { (success, data) in
            
            XCTAssertTrue(success)
            XCTAssertEqual(data, FakeResponseDataImage.correctData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
