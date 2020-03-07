//
//  SettingsViewController.swift
//  Reciplease
//
//  Created by Elie Arquier on 07/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
// MARK: - Outlet
    @IBOutlet weak var languageChoice: UISegmentedControl!

    // Show the right language
    @IBOutlet weak var choiceLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // selected option color
        languageChoice.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black],
                                              for: .normal)

        // color of other options
        languageChoice.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white],
                                              for: .selected)
    }

    override func viewDidAppear(_ animated: Bool) {
        displayLanguage()
        displayCurrentLanguage()
    }
}

// MARK: - Display language preference
extension SettingsViewController {
    /// Display user language choice
    private func displayLanguage() {
        // display Spanish if Spanish is the user's choice
        if UserPreferences.language == Language.spanish.rawValue {
            choiceLabel.text = Spanish.choiceLabel
            saveButton.setTitle(Spanish.saveButton, for: .normal)

        // display English if Spanish is NOT the user's choice:
        // English is the user's choice or user's choice is unknown (case of potential error)
        } else {
            choiceLabel.text = English.choiceLabel
            saveButton.setTitle(English.saveButton, for: .normal)
        }
    }

    /// Load the actual selected language into the segmented control
    private func displayCurrentLanguage() {
        // display Spanish if Spanish is the user's choice
        if UserPreferences.language == Language.spanish.rawValue {
            languageChoice.selectedSegmentIndex = 1

        // display English if Spanish is NOT the user's choice:
        // English is the user's choice or user's choice is unknown (case of potential error)
        } else {
            languageChoice.selectedSegmentIndex = 0
        }
    }
}

// MARK: - Button action
extension SettingsViewController {
    /// When user save is preference
    @IBAction func saveDidTapped(_ sender: UIButton) {
        // Select new preference
        if languageChoice.selectedSegmentIndex == 0 {
            UserPreferences.language = Language.english.rawValue

        } else if languageChoice.selectedSegmentIndex == 1 {
            UserPreferences.language = Language.spanish.rawValue

        // if language selected is not in segmented control possibilities
        } else {
            Notification.alertNotification(alert: .language)
        }

        // Display new preference
        if UserPreferences.language == Language.spanish.rawValue {
            choiceLabel.text = Spanish.choiceLabel
            saveButton.setTitle(Spanish.saveButton, for: .normal)

        } else {
            choiceLabel.text = English.choiceLabel
            saveButton.setTitle(English.saveButton, for: .normal)
        }
    }
}
