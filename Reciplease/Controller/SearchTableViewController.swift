//
//  SearchTableViewController.swift
//  Reciplease
//
//  Created by Elie Arquier on 02/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import UIKit

class SearchTableViewController: UIViewController {
// MARK: - Outlet and property
    @IBOutlet weak var tableView: UITableView!
    
    /// Passing Datas between controllers
    var passData: Recipes?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        // To use reusable custom cell
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "customCell")
    }
}

// MARK: - Use UITableViewDataSource for useful methods
extension SearchTableViewController: UITableViewDataSource {
    /// Number of sections for the table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    /// Number of row for the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passData?.hits.count ?? 0
    }

    /// Display datas to the table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Using custom cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? CustomTableViewCell else {
            return UITableViewCell()
        }

        // Check that there is data
        guard let recipe = passData?.hits[indexPath.row].recipe else {
            return UITableViewCell()
        }

        let recipeImage = recipe.image
        let recipeLabel = recipe.label
        let ingredientsLabel = recipe.ingredientLines
        let recipeLike = recipe.yield
        let recipePreparation = recipe.totalTime

        // Pass data to the custom cell
        cell.displayrecipe(recipeImage: recipeImage, recipeLabel: recipeLabel, ingredientsLabel: ingredientsLabel, recipeLikeLabel: recipeLike, recipePreparationLabel: recipePreparation)

        return cell
    }
}

// MARK: - Use UITableViewDelegate to access recipe detail
extension SearchTableViewController: UITableViewDelegate {}
