//
//  AlertService.swift
//  Reciplease
//
//  Created by Elie Arquier on 06/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import UIKit

class AlertService {
    /// Function alert: add your title, message, action button title and if you need cancel button or not
    static func alert(title: String, message: String, action: String,
                      callback: @escaping () -> Void) -> AlertViewController {
        let storyboard = UIStoryboard(name: "Alert", bundle: .main)
        let alertVC = storyboard.instantiateViewController(identifier: "alertVC") as! AlertViewController

        // Display information in the alert
        alertVC.titleAlert = title
        alertVC.messageAlert = message
        alertVC.actionAlert = action
        alertVC.callback = callback

        return alertVC
    }
}
