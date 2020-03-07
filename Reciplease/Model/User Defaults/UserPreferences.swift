//
//  UserPreferences.swift
//  Reciplease
//
//  Created by Elie Arquier on 07/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import Foundation

class UserPreferences {
    /// Key for use Userdefaults methods
    private struct Keys {
        static let language = "language"
    }

    /// To save the user's preferred language
    static var language: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.language) ?? "English"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.language)
        }
    }
}
