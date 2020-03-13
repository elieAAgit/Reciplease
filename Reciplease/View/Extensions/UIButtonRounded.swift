//
//  UIButton.swift
//  Reciplease
//
//  Created by Elie Arquier on 13/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import UIKit

// MARK: - UIButton custm class: rounded corner and animation
class UIButtonRounded: UIButton {
    override func awakeFromNib() {
        super .awakeFromNib()
        // Rounded corner
        layer.cornerRadius = 10
    }

    /// Add animation when button is tapped
    func animated() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: { (true) in
            self.transform = .identity
        })
    }
}
