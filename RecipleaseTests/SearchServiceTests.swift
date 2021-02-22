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
 
    // MARK: - Properties

    var searchService: SearchService!

    // MARK: - Tests Life Cycle
    
    override func setUp() {
        super.setUp()

        searchService = SearchService()
        searchService.aliments = ["Kiwi", "Bananas"]
    }

    // MARK: - Tests

    func testAddAliment_WhenWantAddAliment_ThenAlimentIsAdded() {
        searchService.addAliment(aliment: "Apple")
        
        XCTAssertEqual(searchService.aliments.count, 3)
        XCTAssertEqual(searchService.aliments[2], "Apple")
    }

    func testParameters_WhenAddInParameters_ThenAlimentsAreAddInParameters() {
        searchService.addAlimentsToParameters()
        
        XCTAssertEqual(ApiUrl.edamanParameters, "Kiwi,Bananas")
    }

    func testRemoveAliment_WhenWantremoveAllAliment_ThenAllAlimentsAreRemove() {
        searchService.removeAliment(at: 0)
        
        XCTAssertEqual(searchService.aliments.count, 1)
        XCTAssertEqual(searchService.aliments[0], "Bananas")
    }

    func testRemoveAliment_WhenWantRemoveOneAliment_ThenAlimentIsRemove() {
        searchService.deleteAliments()
        
        XCTAssertEqual(searchService.aliments.count, 0)
    }
}
