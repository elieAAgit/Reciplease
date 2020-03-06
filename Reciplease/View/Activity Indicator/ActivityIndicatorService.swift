//
//  ActivityIndicatorService.swift
//  Reciplease
//
//  Created by Elie Arquier on 06/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import UIKit

class ActivityIndicatorService {
    var activityIndicator: ActivityIndicatorViewController?

    /// Show Activity indicator view
    func showActivityIndicator() -> ActivityIndicatorViewController {
        let storyboard = UIStoryboard(name: "ActivityIndicator", bundle: .main)
        let activityIndicatorVC = storyboard.instantiateViewController(identifier: "activityIndicatorVC") as! ActivityIndicatorViewController

        activityIndicator = activityIndicatorVC

        return activityIndicatorVC
    }

    /// Dismiss Activity indicator view
    func dismissActivityController() {
        guard let activity = activityIndicator else { return }

        activity.dismissView()
    }
}

