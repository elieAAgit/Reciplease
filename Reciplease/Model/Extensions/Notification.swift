//
//  Notification.swift
//  Reciplease
//
//  Created by Elie Arquier on 06/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import Foundation

extension Notification {
    /// List of alert cases
    enum Alert {
        case textFieldIsEmpty, noAliment, searchUnavailable, addFavorite, deleteFavorite, language
    }

    /// To use an alert
    static func alertNotification(alert: Alert) {
        NotificationCenter.default.post(name: .alert, object: nil, userInfo: ["alert" : alert])
    }
}
