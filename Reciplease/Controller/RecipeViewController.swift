//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Elie Arquier on 04/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
// MARK: - OUtlets and properties
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var numberPartsLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var starNavigation: UIBarButtonItem!
    
    /// Get data from SearchTableViewController
    var recipe: Hits?
    /// Recipe is in user favorites or not
    var favorite: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()

        detailView.layer.cornerRadius = 10
    }

    override func viewDidAppear(_ animated: Bool) {
        displayRecipe()
        favoriteRecipeOrNot()
    }
}

// MARK: - Go to directions
extension RecipeViewController {
    @IBAction func getDirectionsDidTapped(_ sender: UIButton) {
        goToDirections()
    }

    private func goToDirections() {
    }
}

// MARK: - Display recipe
extension RecipeViewController {
    /// Display recipe details in the View
    private func displayRecipe() {
        guard let recipe = recipe?.recipe else { return }

        // Display values
        recipeImage.load(image: recipe.image)
        recipeLabel.text = recipe.label
        numberPartsLabel.text = String(recipe.yield)
        durationLabel.text = String(format:"%.0f", recipe.totalTime) + "m"
        ingredientsTextView.text = recipe.ingredientLines.joined(separator: "\n")
    }
}

// MARK: - Check favorite
extension RecipeViewController {
    /// Check if the recipe is in the favorites
    private func favoriteRecipeOrNot() {
        guard let recipeTitle = recipeLabel.text else { return }

        // Method to check if the recipe is in the database
        FavoritesRecipes.recipeIsFavoriteOrNot(title: recipeTitle) { (favorite) in
            self.favorite = favorite

            // If she is in the database
            if favorite == true {
                starNavigation.tintColor = .yellow

            // If she is not
            } else {
                starNavigation.tintColor = .white
            }
        }
    }

    /// Add or supress favorite
    @IBAction func favoriteButtonDidTapped(_ sender: Any) {
        // If the recipe is in the favorite, suppress the recipe
        if favorite == true {
            guard let recipeTitle = recipeLabel.text else { return }

            // Suppress in the database
            FavoritesRecipes.suppressRecipe(title: recipeTitle)

            // Remove recipe from favorites
            favorite = false
            starNavigation.tintColor = .white

        // If the recipe is not in the favorite, add the recipe
        } else if favorite == false {
            guard let recipe = recipe?.recipe else { return }

             // Add recipe in the database
            FavoritesRecipes.addRecipe(image: recipe.image, label: recipe.label, yield: recipe.yield,
                                       totalTime: recipe.totalTime, ingredientLines: recipe.ingredientLines)

            // Add recipe from favorites
            favorite = true
            starNavigation.tintColor = .yellow
        }
    }
}
