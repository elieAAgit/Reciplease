//
//  ApiImageSessionFake.swift
//  RecipleaseTests
//
//  Created by Elie Arquier on 21/02/2021.
//  Copyright © 2021 Elie Arquier. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
@testable import Reciplease

class ApiImageSessionFake: ImageRequest {
    
    private let fakeResponse: FakeResponse
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }

    func getImage(imageUrl: String, completion: @escaping (AFDataResponse<Data?>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data

        completion(AFDataResponse<Data?>(request: nil, response: httpResponse, data: data, metrics: nil, serializationDuration: 0, result: .success(data)))
    }
}
