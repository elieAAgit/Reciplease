//
//  RecipeDetail.swift
//  Reciplease
//
//  Created by Elie Arquier on 12/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import Foundation

/// To create recipe object
class RecipeDetails {
    // Properties used to display the details of a recipe
    var imageUrl: String
    var label: String
    var ingredientsLabel: String
    var yield: String
    var totalTime: Double

    // Link
    var url: String
    
    init(imageUrl: String, label: String, ingredients: String, yield: String, totalTime: Double, url: String) {

        self.imageUrl = imageUrl
        self.label = label
        self.ingredientsLabel = ingredients
        self.yield = yield
        self.totalTime = totalTime
        self.url = url
    }
}
