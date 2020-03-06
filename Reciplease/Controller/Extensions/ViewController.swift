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

        guard let alert = userInfo["Alert"] as? Notification.Alert else { return }

        // Define the title, message and alert button according to the case
        switch alert {
        case .error:
            title = ""
            message = ""
            action = ""
            cancel = false
        }

        alertVC(title: title, message: message, action: action, cancel: cancel)
    }

    /// To use custom alert
    private func alertVC(title: String, message: String, action: String, cancel: Bool) {
        let alert = AlertService.alert(title: title, message: message, action: action, cancel: cancel)

        // Show alert
        present(alert, animated: true, completion: nil)
    }
}
