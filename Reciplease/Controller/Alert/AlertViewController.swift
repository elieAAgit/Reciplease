//
//  AlertViewController.swift
//  Reciplease
//
//  Created by Elie Arquier on 06/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
// MARK: - Outlets and properties
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var actionLabel: UIButton!
    @IBOutlet weak var cancelLabel: UIButton!

    var titleAlert: String?
    var messageAlert: String?
    var actionAlert: String?
    var cancelAlert: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()

        cornerRadius()
        display()
        DisplayCancelButtonOrNot()
    }
}

// MARK: - Configure alert
extension AlertViewController {
    /// Add round corner
    private func cornerRadius() {
        alertView.layer.cornerRadius = 15
        titleView.roundCorners(corners: [.topLeft, .topRight], radius: 15)
        actionLabel.layer.cornerRadius = 5
        cancelLabel.layer.cornerRadius = 5
        
    }

    /// Display the alert informations in the alert
    private func display() {
        titleLabel.text = titleAlert
        messageLabel.text = messageAlert
        actionLabel.setTitle(actionAlert, for: .normal)
    }

    /// Display or not cancel button
    private func DisplayCancelButtonOrNot() {
        if cancelAlert == true {
            cancelLabel.isHidden = true

        } else {
            cancelLabel.isHidden = false
        }
    }
}

// MARK: - Actions buttons
extension AlertViewController {
    @IBAction func actionButtonDidTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelButtonDidTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
