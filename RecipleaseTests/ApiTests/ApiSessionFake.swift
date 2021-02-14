//
//  ApiSessionFake.swift
//  RecipleaseTests
//
//  Created by Elie Arquier on 13/02/2021.
//  Copyright © 2021 Elie Arquier. All rights reserved.
//

@testable import Reciplease
import Foundation
import Alamofire

class ApiSessionFake: RecipeRequest {
    
    private let fakeResponse: FakeResponse
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }

    func getRecipe(url: String, completion: @escaping (AFDataResponse<Any>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        
        completion(AFDataResponse<Any>(request: nil, response: httpResponse, data: data, metrics: nil, serializationDuration: 0, result: .success("OK")))
    }
}
