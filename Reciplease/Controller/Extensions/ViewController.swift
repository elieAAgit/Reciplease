//
//  ViewController.swift
//  Reciplease
//
//  Created by Elie Arquier on 06/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import UIKit

// MARK: - Extension to open url
extension UIViewController {
    func webViewRecipe(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}

extension UIViewController {
    /// Alert
    @objc func alert(notification: Notification) {
        var title: String
        var message: String
        var action: String

        guard let userInfo = notification.userInfo else { return }

        guard let alert = userInfo["alert"] as? Notification.Alert else { return }

        // display Spanish if Spanish is the user's choice
        if UserPreferences.language == Language.spanish.rawValue {
            // Define the title, message and alert button according to the case
            switch alert {
                case .textFieldIsEmpty:
                    title = "Personaje perdido"
                    message = "TextField está vacío."
                    action = "Hecho"
                case .noAliment:
                    title = "Su busqueda esta vacia"
                    message = "Agregue al menos un alimento."
                    action = "Hecho"
                case .searchUnavailable:
                    title = "Búsqueda no disponible"
                    message = "La búsqueda no está disponible."
                    action = "Hecho"
                case .addFavorite:
                    title = "Añadir favorito"
                    message = "Has agregado esta receta a tu favorito."
                    action = "Hecho"
                case .deleteFavorite:
                    title = "Eliminar favorito"
                    message = "Has eliminado esta receta a tu favorito."
                    action = "Hecho"
                case .language:
                    title = "Idioma desconocido"
                    message = "Este idioma lamentablemente no está disponible."
                    action = "Hecho"
            }

        // display English if Spanish is NOT the user's choice:
        } else {
            // Define the title, message and alert button according to the case
            switch alert {
                case .textFieldIsEmpty:
                    title = "Character missing"
                    message = "TextField is empty."
                    action = "Done"
                case .noAliment:
                    title = "Your search is empty"
                    message = "Add at least one food."
                    action = "Done"
                case .searchUnavailable:
                    title = "Search unavailable"
                    message = "The search is unavailable."
                    action = "Done"
                case .addFavorite:
                    title = "Add favorite"
                    message = "You have add this recipe to your favorite."
                    action = "Done"
                case .deleteFavorite:
                    title = "Delete favorite"
                    message = "You have delete this recipe to your favorite."
                    action = "Ok"
                case .language:
                    title = "Language unknown"
                    message = "This language is unfortunately unavailable."
                    action = "Done"
            }
        }

        alertVC(title: title, message: message, action: action)
    }

    /// To use custom alert
    private func alertVC(title: String, message: String, action: String) {
        let alert = AlertService.alert(title: title, message: message, action: action) {}

        // Show alert
        self.tabBarController?.present(alert, animated: true, completion: nil)
    }
}
