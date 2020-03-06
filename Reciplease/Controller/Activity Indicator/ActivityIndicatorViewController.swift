//
//  ActivityIndicatorViewController.swift
//  Reciplease
//
//  Created by Elie Arquier on 06/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import UIKit

class ActivityIndicatorViewController: UIViewController {
// MARK: - Outlet
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        showActivityIndicator()
    }
}

// MARK: - Activity indicator statements
extension ActivityIndicatorViewController {
    /// Animating activity indicator when view appear
    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }

    /// Dismiss view and stop animating activity indicator when view disappear
    func dismissView() {
        // To prevent unexpectedly nil
        if self.presentingViewController != nil {
            dismiss(animated: true) {
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
