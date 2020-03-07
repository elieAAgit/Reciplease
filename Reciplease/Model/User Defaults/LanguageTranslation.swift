//
//  LanguageTranslation.swift
//  Reciplease
//
//  Created by Elie Arquier on 07/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import Foundation

/// List of languages
enum Language: String {
    case english = "English"
    case spanish = "Español"
}

struct English {
    static var titleLabel = "What's in your fridge?"
    static var ingredientsLabel = "ingredients"
    static var addButton = "add"
    static var clearButton = "clear"
    static var searchButton = "search"
    static var choiceLabel = "Choose your language"
    static var saveButton = "save"
    static var getDirectionsButton = "get directions"
}

struct Spanish {
    static var titleLabel = "¿Qué hay en tu refrigerador?"
    static var ingredientsLabel = "ingredientes"
    static var addButton = "añadir"
    static var clearButton = "quitar"
    static var searchButton = "buscar"
    static var choiceLabel = "Elige tu idioma"
    static var saveButton = "salvar"
    static var getDirectionsButton = "obtener las direcciones"
}
