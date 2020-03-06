//
//  ApiService.swift
//  Reciplease
//
//  Created by Elie Arquier on 03/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import Foundation
import Alamofire

struct ApiService {
    // Singleton pattern
    static var shared = ApiService()
    private init() {}

    typealias completion = (Bool, Recipes?) -> Void

    /// Alamofire request
    func getRecipe(url: String, completion: @escaping completion) {
        AF.request(url).validate().responseData { (response) in
            switch response.result {
                case .success(let value):
                    let recipes = try? JSONDecoder().decode(Recipes.self, from: value)
                    completion(true, recipes)
                case .failure(let error):
                    completion(false, nil)
                    print(error)
            }
        }
    }
}
