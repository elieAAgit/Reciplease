//
//  ApiKeys.swift
//  Reciplease
//
//  Created by Elie Arquier on 03/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import Foundation

/// To access the keys of the ApiKeys.plist file
func valueForAPIKey(named keyname: String) -> String {
    let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let value = plist?.object(forKey: keyname) as! String
    return value
}
