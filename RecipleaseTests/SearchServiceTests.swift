//
//  SearchServiceTests.swift
//  RecipleaseTests
//
//  Created by Elie Arquier on 19/02/2021.
//  Copyright © 2021 Elie Arquier. All rights reserved.
//

import XCTest
@testable import Reciplease

class SearchServiceTests: XCTestCase {
    
    var searchService: SearchService!

    override func setUp() {
        super.setUp()

        searchService = SearchService()
        searchService.aliments = ["Kiwi", "Bananas"]
    }

    func testGetWhenThen() {
        searchService.addAliment(aliment: "Apple")
        
        XCTAssertEqual(searchService.aliments.count, 3)
        XCTAssertEqual(searchService.aliments[2], "Apple")
    }

    func test() {
        searchService.addAlimentsToParameters()
        
        XCTAssertEqual(ApiUrl.edamanParameters, "Kiwi,Bananas")
    }

    func test1() {
        searchService.removeAliment(at: 0)
        
        XCTAssertEqual(searchService.aliments.count, 1)
        XCTAssertEqual(searchService.aliments[0], "Bananas")
    }

    func test2() {
        searchService.deleteAliments()
        
        XCTAssertEqual(searchService.aliments.count, 0)
    }
}
