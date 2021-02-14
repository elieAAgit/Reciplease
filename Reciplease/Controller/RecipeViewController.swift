//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Elie Arquier on 04/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
// MARK: - Outlets and properties
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var numberPartsLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var starNavigation: UIBarButtonItem!

    // Show the right language
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var getDirectionsButton: UIButtonRounded!

    /// Get data from SearchTableViewController
    var recipeDetails: RecipeDetails?
    /// Recipe is in user favorites or not
    var favorite: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()

        detailView.layer.cornerRadius = 10
    }

    override func viewDidAppear(_ animated: Bool) {
        displayLanguage()
        displayRecipe()
        favoriteRecipeOrNot()
    }
}

// MARK: - Go to directions
extension RecipeViewController {
    @IBAction func getDirectionsDidTapped(_ sender: UIButtonRounded) {
        sender.animated()

        guard let url = recipeDetails?.url else { return }

        webViewRecipe(urlString: url)
    }
}

// MARK: - Display recipe
extension RecipeViewController {
    /// Display user language choice
    private func displayLanguage() {
        // display Spanish if Spanish is the user's choice
        if UserPreferences.language == Language.spanish.rawValue {
            ingredientsLabel.text = Spanish.ingredientsLabel
            getDirectionsButton.setTitle(Spanish.getDirectionsButton, for: .normal)

        // display English if Spanish is NOT the user's choice:
        // English is the user's choice or user's choice is unknown (case of potential error)
        } else {
            ingredientsLabel.text = English.ingredientsLabel
            getDirectionsButton.setTitle(English.getDirectionsButton, for: .normal)
        }
    }

    /// Display recipe details in the View
    private func displayRecipe() {
        guard let recipe = recipeDetails else { return }

        // Display values
        recipeImage.load(imageUrl: recipe.imageUrl)
        recipeLabel.text = recipe.label
        numberPartsLabel.text = String(recipe.yield)
        durationLabel.text = String(format:"%.0f", recipe.totalTime) + " m"
        ingredientsTextView.text = recipe.ingredientsLabel
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
        deleteOrAddRecipeToFavorite()
    }
    
    private func deleteOrAddRecipeToFavorite() {
        // If the recipe is in the favorite, suppress the recipe
        if favorite == true {
            guard let recipeTitle = recipeLabel.text else { return }

            // Suppress in the database
            FavoritesRecipes.suppressRecipe(title: recipeTitle)

            // Remove recipe from favorites
            favorite = false
            starNavigation.tintColor = .white

            // Show alert to confirm deleting
            Notification.alertNotification(alert: .deleteFavorite)

        // If the recipe is not in the favorite, add the recipe
        } else if favorite == false {
            guard let recipe = recipeDetails else { return }

            // Add recipe in the database
            FavoritesRecipes.addRecipe(image: recipe.imageUrl, label: recipe.label, yield: recipe.yield,
                                       totalTime: recipe.totalTime, ingredientLines: recipe.ingredientsLabel, url: recipe.url)

            // Add recipe from favorites
            favorite = true
            starNavigation.tintColor = .yellow

            // Show alert to confirm adding
            Notification.alertNotification(alert: .addFavorite)
        }
    }
}
