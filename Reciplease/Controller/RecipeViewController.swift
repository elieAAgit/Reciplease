//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Elie Arquier on 04/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
// MARK: - OUtlets and property
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var numberPartsLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!

    /// Get data from SearchTableViewController
    var recipe: Hits?

    override func viewDidLoad() {
        super.viewDidLoad()

        detailView.layer.cornerRadius = 10
    }

    override func viewDidAppear(_ animated: Bool) {
        displayRecipe()
    }
}

extension RecipeViewController {
    /// Display recipe details in the View
    private func displayRecipe() {
        guard let recipe = recipe?.recipe else { return }

        recipeImage.load(image: recipe.image)
        recipeLabel.text = recipe.label
        numberPartsLabel.text = String(recipe.yield)
        durationLabel.text = String(format:"%.0f", recipe.totalTime) + "m"
        ingredientsTextView.text = recipe.ingredientLines.joined(separator: "\n")
    }
}
