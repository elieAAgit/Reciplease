//
//  ApiService.swift
//  Reciplease
//
//  Created by Elie Arquier on 03/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import Foundation

final class ApiService {

    private let recipeRequest: RecipeRequest
    
    init(recipeRequest: RecipeRequest = AlamofireSession()) {
        self.recipeRequest = recipeRequest
    }

    /// Alamofire request
    func getRecipe(url: String, completion: @escaping (Bool, Recipes?) -> Void) {

        recipeRequest.getRecipe(url: url) { responseData in
            guard responseData.response?.statusCode == 200 else {
                completion(false, nil)
                return Notification.alertNotification(alert: .noConnexion)
            }

            guard let data = responseData.data else {
                completion(false, nil)
                return Notification.alertNotification(alert: .searchUnavailable)
            }

            guard let recipeSearch = try? JSONDecoder().decode(Recipes.self, from: data) else {
                completion(false, nil)
                return
            }

            completion(true, recipeSearch)
        }
    }
}
