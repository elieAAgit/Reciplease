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

    /// To load and updated data in tableView
    static var fetchedResultsController: NSFetchedResultsController<FavoritesRecipes> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<FavoritesRecipes> = FavoritesRecipes.fetchRequest()

        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "label", ascending: true)]

        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)

        return fetchedResultsController
    }()

    /// Load fetch
    static func loadPersistant() {
        do {
            try FavoritesRecipes.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
    }

    /// Add recipe in Database as favorite
    static func addRecipe(image: String, label: String, yield: String,
                          totalTime: Double, ingredientLines: String, url: String) {
        let favoritesRecipes = FavoritesRecipes(context: context)

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
