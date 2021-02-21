//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Elie Arquier on 01/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
// MARK: - Outlets and properties
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTableView: UITableView!

    // Show the right language
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var addButton: UIButtonRounded!
    @IBOutlet weak var clearButton: UIButtonRounded!
    @IBOutlet weak var searchButton: UIButtonRounded!
    

    let apiService = ApiService()
    /// Instance of SearchService
    let search = SearchService()
    /// To show activity indicator when a search is made
    let activityIndicator = ActivityIndicatorService()

    /// Passing Data between controllers
    var recipes: Recipes?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Observe to display alert
        NotificationCenter.default.addObserver(self, selector: #selector(alert(notification:)), name: .alert, object: nil)

        searchTextField.delegate = self
        searchTableView.dataSource = self
        searchTableView.delegate = self
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .alert, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        displayLanguage()
    }
}

// MARK: - Display user language choice
extension SearchViewController {
    /// display the user's choice language
    private func displayLanguage() {
        // display Spanish if Spanish is the user's choice
        if UserPreferences.language == Language.spanish.rawValue {
            titleLabel.text = Spanish.titleLabel
            ingredientsLabel.text = Spanish.ingredientsLabel
            addButton.setTitle(Spanish.addButton, for: .normal)
            clearButton.setTitle(Spanish.clearButton, for: .normal)
            searchButton.setTitle(Spanish.searchButton, for: .normal)

        // display English if Spanish is NOT the user's choice:
        // English is the user's choice or user's choice is unknown (case of potential error)
        } else {
            titleLabel.text = English.titleLabel
            ingredientsLabel.text = English.ingredientsLabel
            addButton.setTitle(English.addButton, for: .normal)
            clearButton.setTitle(English.clearButton, for: .normal)
            searchButton.setTitle(English.searchButton, for: .normal)
        }
    }
}

// MARK: - Actions buttons
extension SearchViewController {
    /// Add aliment to the aliments user selection
    @IBAction func addButtonDidTapped(_ sender: UIButtonRounded) {
        sender.animated()

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
            Notification.alertNotification(alert: .textFieldIsEmpty)
        }
    }

    /// Clear the selection of aliments and suppress all entries
    @IBAction func clearButtonDidTapped(_ sender: UIButtonRounded) {
        sender.animated()

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
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            self.search.removeAliment(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }

        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// MARK: - Network call with Alamofire to search recipes
extension SearchViewController {
    /// Segue to SearchTableViewController. Passing data
    @IBAction func searchButtonDidTapped(_ sender: UIButtonRounded) {
        sender.animated()

        sendingOfData()
    }

    /// Sending data to SearchTableViewController
    private func sendingOfData() {
        if search.aliments.isEmpty {
            // Show alert
            Notification.alertNotification(alert: .noAliment)

        } else {
            present(activityIndicator.showActivityIndicator(), animated: true, completion: nil)

            // Add parameters to Url
            search.addAlimentsToParameters()

            // Network call
            apiService.getRecipe(url: ApiUrl.edamanUrl) { (success, response) in
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
                    Notification.alertNotification(alert: .searchUnavailable)
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
