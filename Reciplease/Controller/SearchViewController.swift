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

    /// Passing Datas between controllers
    var passData: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self
    }
}

// MARK: - Actions buttons
extension SearchViewController {
    /// Add aliment to the aliments user selection
    @IBAction func addButtonDidTapped(_ sender: UIButton) {
        guard let newAliment = searchTextField.text, var aliments = contentView.text else { return }

        // Add new aliment
        aliments += "- " + newAliment + "\n"
        contentView.text = aliments

        // Clear textField for the next aliment
        searchTextField.text = nil

        // Add aliment in data array to pass with the segue
        passData.append(newAliment)
    }

    /// Clear the selection of aliments and suppress all entries in passData array
    @IBAction func clearButtonDidTapped(_ sender: UIButton) {
        contentView.text = nil
        passData = []
    }

    /// Segue to SearchTableViewController. Passing data
    @IBAction func searchButtonDidTapped(_ sender: UIButton) {
        performSegue(withIdentifier: SegueIdentifiers.searchToSearchTableView.rawValue, sender: self)
    }
}

// MARK: - Prepare segue
extension SearchViewController {
    /// Prepare Data for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
