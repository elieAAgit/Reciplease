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
    @IBOutlet weak var contentView: UITextView!

    /// List of aliments for network call
    var aliments: [String] = []

    /// Passing Datas between controllers
    var passData: Recipes?

    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self
    }
}

// MARK: - Actions buttons
extension SearchViewController {
    /// Add aliment to the aliments user selection
    @IBAction func addButtonDidTapped(_ sender: UIButton) {
        guard let newAliment = searchTextField.text, var aliment = contentView.text else { return }

        // Add new aliment
        aliment += "- " + newAliment + "\n"
        contentView.text = aliment

        // Clear textField for the next aliment
        searchTextField.text = nil

        // Add aliment in aliments array to pass with the segue
        aliments.append(newAliment)
    }

    /// Clear the selection of aliments and suppress all entries in passData array
    @IBAction func clearButtonDidTapped(_ sender: UIButton) {
        contentView.text = nil
        aliments = []
    }

    /// Segue to SearchTableViewController. Passing data
    @IBAction func searchButtonDidTapped(_ sender: UIButton) {
        /// Prepare aliments for Url parameters
        var addAliments: String {
            return aliments.joined(separator: ",")
        }

        // Add parameters to Url
        ApiUrl.edamanParameters = addAliments

        // Network call
        ApiService.getRecipe(url: ApiUrl.edamanUrl) { (response) in
            guard let response = response else { return }

            // Data for SearchTableViewController
            self.passData = response

            self.performSegue(withIdentifier: SegueIdentifiers.searchToSearchTableView.rawValue, sender: self)
        }
    }
}

// MARK: - Prepare segue
extension SearchViewController {
    /// Prepare Data for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let passData = passData else { return }

        if segue.identifier == SegueIdentifiers.searchToSearchTableView.rawValue {
            let searchTableViewController = segue.destination as! SearchTableViewController
            searchTableViewController.passData = passData
        }
    }
}

// MARK: - Dissmiss Keyboard
extension SearchViewController: UITextFieldDelegate {
    /// Dissmiss keyboard when user touch screen
    @IBAction func dissmissKeyboard() {
        hideKeyboard()
    }

    /// Dissmiss keyboard when 'return' button is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()

        return true
    }

    /// Dissmiss keyboard
    private func hideKeyboard() {
        searchTextField.resignFirstResponder()
    }
}
