//
//  ApiUrl.swift
//  Reciplease
//
//  Created by Elie Arquier on 03/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import Foundation

/// Prepare Url for Edaman API request
struct ApiUrl {
    static private let edamanPath = "https://api.edamam.com/search?"
    static private let edamanAppId = "app_id=\(valueForAPIKey(named: "appId"))"
    static private let edamanAppKey = "&app_key=\(valueForAPIKey(named: "appKey"))"
    static private let edamanParam = "&q="
    static var edamanParameters = ""
    static private let edamanNumbers = "&to=30"

    /// Url for Edaman API request
    static var edamanUrl: String {
        return edamanPath + edamanAppId + edamanAppKey + edamanParam + edamanParameters + edamanNumbers
    }
}
