//
//  SearchService.swift
//  Reciplease
//
//  Created by Elie Arquier on 06/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import Foundation

final class SearchService {
    /// List of aliments for network call
    var aliments: [String] = []

    /// Add aliment to aliments array
    func addAliment(aliment: String) {
        aliments.append(aliment)
    }

    /// Construct Api parameters
    func addAlimentsToParameters() {
        /// Prepare aliments for Url parameters
        var addAliments: String {
            return aliments.joined(separator: ",")
        }

        // Add parameters to Url
        ApiUrl.edamanParameters = addAliments
    }

    /// Delete one aliment
    func removeAliment(at index: Int) {
        aliments.remove(at: index)
    }

    /// Delete all aliments
    func deleteAliments() {
        aliments = []
    }
}
