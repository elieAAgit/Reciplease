//
//  FavouritesManager.swift
//  Reciplease
//
//  Created by Elie Arquier on 15/02/2021.
//  Copyright © 2021 Elie Arquier. All rights reserved.
//

import Foundation
import CoreData

final class FavoritesManager {

    // Property
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    /// To load and updated data in tableView
    var fetchedResultsController: [SavesRecipes] {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<SavesRecipes> = SavesRecipes.fetchRequest()

        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "label", ascending: true)]

        // Create Fetched Results Controller
        guard let tasks = try? context.fetch(fetchRequest) else { return [] }
                return tasks
    }
    
    /// Add recipe in Database as favorite
    func addRecipe(image: String, label: String, yield: String,
                          totalTime: Double, ingredientLines: String, url: String) {
        let favoritesRecipes = SavesRecipes(context: context)

        // Add data
        favoritesRecipes.label = label
        favoritesRecipes.image = image
        favoritesRecipes.yield = yield
        favoritesRecipes.totalTime = totalTime
        favoritesRecipes.ingredientLines = ingredientLines
        favoritesRecipes.url = url

        try? context.save()
    }

    /// Suppress recipe in Database as favorite
    func suppressRecipe(title: String) {
        let request: NSFetchRequest<SavesRecipes> = SavesRecipes.fetchRequest()
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
    func recipeIsFavoriteOrNot(title: String, completion: (Bool) -> Void ) {
        var favorite = true

        let request: NSFetchRequest<SavesRecipes> = SavesRecipes.fetchRequest()
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


