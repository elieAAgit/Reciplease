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

        // display Spanish if Spanish is the user's choice
        if UserPreferences.language == Language.spanish.rawValue {
            // Define the title, message and alert button according to the case
            switch alert {
                case .textFieldIsEmpty:
                    title = "Personaje perdido"
                    message = "TextField está vacío."
                    action = "Hecho"
                    cancel = false
                case .noAliment:
                    title = "Su busqueda esta vacia"
                    message = "Agregue al menos un alimento."
                    action = "Hecho"
                    cancel = false
                case .searchUnavailable:
                    title = "Búsqueda no disponible"
                    message = "La búsqueda no está disponible."
                    action = "Hecho"
                    cancel = false
                case .addFavorite:
                    title = "Añadir favorito"
                    message = "Has agregado esta receta a tu favorito."
                    action = "Hecho"
                    cancel = false
                case .deleteFavorite:
                    title = "Eliminar favorito"
                    message = "¿Quieres eliminar esta receta a tu favorito?"
                    action = "Yes"
                    cancel = true
                case .language:
                    title = "Idioma desconocido"
                    message = "Este idioma lamentablemente no está disponible."
                    action = "Hecho"
                    cancel = false
            }

        // display English if Spanish is NOT the user's choice:
        } else {
            // Define the title, message and alert button according to the case
            switch alert {
                case .textFieldIsEmpty:
                    title = "Character missing"
                    message = "TextField is empty."
                    action = "Done"
                    cancel = false
                case .noAliment:
                    title = "Your search is empty"
                    message = "Add at least one food."
                    action = "Done"
                    cancel = false
                case .searchUnavailable:
                    title = "Search unavailable"
                    message = "The search is unavailable."
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
                case .language:
                    title = "Language unknown"
                    message = "This language is unfortunately unavailable."
                    action = "Done"
                    cancel = false
            }
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
