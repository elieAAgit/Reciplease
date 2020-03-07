//
//  ViewController.swift
//  Reciplease
//
//  Created by Elie Arquier on 06/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import UIKit

extension UIViewController {
    ///
    @objc func alert(notification: Notification) {
        var title: String
        var message: String
        var action: String
        var cancel: Bool

        guard let userInfo = notification.userInfo else { return }

        guard let alert = userInfo["alert"] as? Notification.Alert else { return }

        // Define the title, message and alert button according to the case
        switch alert {
            case .textFieldIsEmpty:
                title = "Character missing"
                message = "textField is empty."
                action = "Done"
                cancel = false
            case .noAliment:
                title = "Your search is empty"
                message = "Add at least one food."
                action = "Done"
                cancel = false
            case .searchUnavailable:
                title = "Search unavailable"
                message = "the search is unavailable."
                action = "Done"
                cancel = false
            case .addFavorite:
                title = "Add favorite"
                message = "You have add this recipe to your favorite."
                action = "Done"
                cancel = false
            case .deleteFavorite:
                title = "Delete favorite"
                message = "Do you want delete this recipe to your favorite?"
                action = "Yes"
                cancel = true
        }

        alertVC(title: title, message: message, action: action, cancel: cancel)
    }

    /// To use custom alert
    private func alertVC(title: String, message: String, action: String, cancel: Bool) {
        let alert = AlertService.alert(title: title, message: message, action: action, cancel: cancel) {}

        // Show alert
        self.tabBarController?.present(alert, animated: true, completion: nil)
    }
}
