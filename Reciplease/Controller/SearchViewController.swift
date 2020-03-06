//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Elie Arquier on 01/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
// MARK: - Outlets and properties
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTableView: UITableView!

    /// Instance of SearchService
    let search = SearchService()
    /// To show activity indicator when a search is made
    let activityIndicator = ActivityIndicatorService()

    /// Passing Data between controllers
    var recipes: Recipes?

    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self
        searchTableView.dataSource = self
        searchTableView.delegate = self
    }
}

// MARK: - Actions buttons
extension SearchViewController {
    /// Add aliment to the aliments user selection
    @IBAction func addButtonDidTapped(_ sender: UIButton) {
        addAliment()
    }

    /// Add aliment
    private func addAliment() {
        guard let aliment = searchTextField.text else { return }

        // Suppress whitespaces
        let newAliment = aliment.trimmingCharacters(in: .whitespacesAndNewlines)

        // At least one character
        if searchTextField.text != "" {

            // Add aliment in aliments array to pass with the segue
            search.addAliment(aliment: newAliment)

            // Reload table view to display food
            searchTableView.reloadData()

            // Clear textField for the next aliment
            searchTextField.text = ""

        // If textField is empty
        } else {
            // Show alert
            print("textField is empty")
        }
    }

    /// Clear the selection of aliments and suppress all entries
    @IBAction func clearButtonDidTapped(_ sender: UIButton) {
        search.deleteAliments()
        searchTableView.reloadData()
    }
}

// MARK: - TableView
extension SearchViewController: UITableViewDataSource {
    /// Number of section in the table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    /// Number of aliments
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return search.aliments.count
    }

    /// display aliments
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") else {
            return UITableViewCell()
        }

        cell.textLabel?.text = "- " + search.aliments[indexPath.row]

        return cell
    }
}

// MARK: - TableView cell delete
extension SearchViewController: UITableViewDelegate {
    /// Delete aliment in table view
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "X") { (action, view, success) in
            self.search.removeAliment(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }

        delete.backgroundColor = .gray

        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// MARK: - Network call with Alamofire to search recipes
extension SearchViewController {
    /// Segue to SearchTableViewController. Passing data
    @IBAction func searchButtonDidTapped(_ sender: UIButton) {
        sendingOfData()
    }

    /// Sending data to SearchTableViewController
    private func sendingOfData() {
        if search.aliments.isEmpty {
            // Show alert
            print("no aliment")

        } else {
            present(activityIndicator.showActivityIndicator(), animated: true, completion: nil)

            // Add parameters to Url
            search.addAlimentsToParameters()

            // Network call
            ApiService.shared.getRecipe(url: ApiUrl.edamanUrl) { (success, response) in
                if success {
                    // Dismiss activity indicator
                    self.activityIndicator.dismissActivityController()

                    guard let response = response else { return }

                    // Data for SearchTableViewController
                    self.recipes = response

                    // Perform segue
                    self.performSegue(withIdentifier: SegueIdentifiers.searchToSearchTableView.rawValue, sender: self)

                } else {
                    // Dismiss activity indicator
                    self.activityIndicator.dismissActivityController()

                    // Show alert
                }
            }
        }
    }
}

// MARK: - Prepare segue
extension SearchViewController {
    /// Prepare Data for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipes = recipes else { return }

        if segue.identifier == SegueIdentifiers.searchToSearchTableView.rawValue {
            let searchTableViewController = segue.destination as! SearchTableViewController
            searchTableViewController.passData = recipes
        }
    }
}

// MARK: - Dismiss Keyboard
extension SearchViewController: UITextFieldDelegate {
    /// Dismiss keyboard when user touch screen
    @IBAction func dissmissKeyboard() {
        hideKeyboard()
    }

    /// Dismiss keyboard when 'return' button is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()

        return true
    }

    /// Dismiss keyboard
    private func hideKeyboard() {
        searchTextField.resignFirstResponder()
    }
}
