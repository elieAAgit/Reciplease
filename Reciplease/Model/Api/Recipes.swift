//
//  Recipes.swift
//  Reciplease
//
//  Created by Elie Arquier on 03/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import Foundation

struct Recipes: Decodable {
    let q: String
    let from: Int
    let to: Int
    let more: Bool
    let count: Int
    let hits: [Hits]
}

struct Hits: Decodable {
    let recipe: Recipe
}

struct Recipe: Decodable {
    let uri: String
    let label: String
    let image: String
    let source: String
    let url: String
    let shareAs: String
    let yield: Int
    let dietLabels: [String]
    let healthLabels:[String]
    let cautions: [String]
    let ingredientLines: [String]
    let ingredients: [Ingredients]
    let calories: Double
    let totalWeight: Double
    let totalTime: Double
}

struct Ingredients: Decodable {
    let text: String
    let weight: Double
}

