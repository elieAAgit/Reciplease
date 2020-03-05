//
//  FavoritesRecipes.swift
//  Reciplease
//
//  Created by Elie Arquier on 05/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import Foundation
import CoreData

class FavoritesRecipes: NSManagedObject {
    static let context = AppDelegate.viewContext

    /// Add recipe in Database as favorite
    static func addRecipe(image: String, label: String, yield: Int,
                           totalTime: Double, ingredientLines: [String]) {
        let favoritesRecipes = FavoritesRecipes(context: context)

        // Add data
        favoritesRecipes.label = label
        favoritesRecipes.image = image
        favoritesRecipes.yield = String(yield)
        favoritesRecipes.totalTime = totalTime
        favoritesRecipes.ingredientLines = ingredientLines.joined(separator: "\n")

        try? context.save()
    }

    /// Suppress recipe in Database as favorite
    static func suppressRecipe(title: String) {
        let request: NSFetchRequest<FavoritesRecipes> = FavoritesRecipes.fetchRequest()
        request.predicate = NSPredicate(format: "label == %@", title)

        // If the recipe is in the favorites, she is deleted
        if let result = try? context.fetch(request) {
            for object in result {
                context.delete(object)
            }
        }

        try? context.save()
    }

    /// Check if the recipe is in the favorites
    static func recipeIsFavoriteOrNot(title: String, completion: (Bool) -> Void ) {
        var favorite = true

        let request: NSFetchRequest<FavoritesRecipes> = FavoritesRecipes.fetchRequest()
        request.predicate = NSPredicate(format: "label == %@", title)

        // Array with the recipe, or not
        guard let result = try? context.fetch(request) else { return }

        // If the recipe is not in the favorites
        if result.isEmpty {
            favorite = false
        }

        completion(favorite)
    }
}
