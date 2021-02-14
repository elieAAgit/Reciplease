//
//  RecipeRequestProtocol.swift
//  Reciplease
//
//  Created by Elie Arquier on 14/02/2021.
//  Copyright © 2021 Elie Arquier. All rights reserved.
//

import Foundation
import Alamofire

protocol RecipeRequest {
    func getRecipe(url: String, completion: @escaping (AFDataResponse<Any>) -> Void)
}
