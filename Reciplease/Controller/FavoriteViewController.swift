//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Elie Arquier on 02/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
// MARK: - Outlets and property
    @IBOutlet weak var missingFavoritesLabel: UILabel!
    @IBOutlet weak var favoriteTableView: UITableView!

    var favoritesManager: FavoritesManager?
    /// To pass recipe between controller
    var recipeDetails: RecipeDetails?

    override func viewDidLoad() {
        super.viewDidLoad()

        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self

        // To use reusable custom cell
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        favoriteTableView.register(nib, forCellReuseIdentifier: CustomTableViewCell.cellIdentifier)

        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appdelegate.coreDataStack
        favoritesManager = FavoritesManager(context: coreDataStack.viewContext)

        updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteTableView.reloadData()

        updateView()
    }
}

// MARK: - Loading and updating view
extension FavoriteViewController {
    /// Show table view if obejects in database > 0, else show indicative message
    fileprivate func updateView() {
        var hasEntry = false

        if let entities = favoritesManager?.fetchedResultsController {
            hasEntry = entities.count > 0
        }
        favoriteTableView.isHidden = !hasEntry
        missingFavoritesLabel.isHidden = hasEntry
    }
}

// MARK: - Display favorites recipes in the table view
extension FavoriteViewController: UITableViewDataSource {
    /// Number of sections for the table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    /// Number of row for the table view: number of favorites in the database
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let entities = favoritesManager?.fetchedResultsController else { return 0 }

        return entities.count
    }

    /// Display data to the table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.cellIdentifier)
            as? CustomTableViewCell else {
            return UITableViewCell()
        }

        // Fetch recipes
        let recipe = favoritesManager?.fetchedResultsController[indexPath.row]

        guard let recipeImage = recipe?.image else {return UITableViewCell() }
        guard let recipeLabel = recipe?.label else {return UITableViewCell() }
        guard let ingredientsLabel = recipe?.ingredientLines else {return UITableViewCell() }
        guard let recipeLike = recipe?.yield else {return UITableViewCell() }
        guard let recipePreparation = recipe?.totalTime else { return UITableViewCell() }

        // Pass data to the custom cell
        cell.displayrecipe(recipeImage: recipeImage, recipeLabel: recipeLabel, ingredientsLabel: ingredientsLabel, recipeLikeLabel: recipeLike, recipePreparationLabel: recipePreparation)

        return cell
    }
}

// MARK: - Manage adding and deleting cell in table view
extension FavoriteViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        favoriteTableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        favoriteTableView.endUpdates()

        updateView()
    }

    /// Insert or suppress cell in the table view
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                favoriteTableView.insertRows(at: [indexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                favoriteTableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            print("Other case.")
        }
    }
}

// MARK: - Use UITableViewDelegate to access recipe detail
extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Fetch recipes
        let recipe = favoritesManager?.fetchedResultsController[indexPath.row]

        // Access the recipe details
        guard let image = recipe?.image else { return }
        guard let label = recipe?.label else { return }
        guard let ingredients = recipe?.ingredientLines else { return }
        guard let yield = recipe?.yield else { return }
        guard let url = recipe?.url else { return }
        guard let time = recipe?.totalTime else { return }

        // Recipe for RecipeViewController
        recipeDetails = RecipeDetails(imageUrl: image, label: label, ingredients: ingredients,
                                      yield: yield, totalTime: time, url: url)

        performSegue(withIdentifier: SegueIdentifiers.favoriteTableToRecipe.rawValue, sender: self)
    }
}

// MARK: - Prepare segue
extension FavoriteViewController {
    /// Prepare data for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.favoriteTableToRecipe.rawValue {
            let recipeViewController = segue.destination as! RecipeViewController
            // Pass recipe between controllers
            recipeViewController.recipeDetails = recipeDetails
        }
    }
}
