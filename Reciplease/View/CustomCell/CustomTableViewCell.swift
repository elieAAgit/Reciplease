//
//  CustomTableViewCell.swift
//  Reciplease
//
//  Created by Elie Arquier on 03/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
// MARK: - Outlets and property
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var recipeLikeLabel: UILabel!
    @IBOutlet weak var recipePreparationLabel: UILabel!

    /// Name of the custom cell
    static let cellIdentifier = "customCell"

    override func awakeFromNib() {
        super.awakeFromNib()

        detailView.layer.cornerRadius = 10
    }
}

// MARK: - Method
extension CustomTableViewCell {
    /// To display data in custom cell
    func displayrecipe(recipeImage: String, recipeLabel: String, ingredientsLabel: String,
                       recipeLikeLabel: String, recipePreparationLabel: Double) {

        // Display data in custom cell labels and image
        self.recipeImage.load(image: recipeImage)
        self.recipeLabel.text = recipeLabel
        self.ingredientsLabel.text = ingredientsLabel
        self.recipeLikeLabel.text = recipeLikeLabel
        self.recipePreparationLabel.text = String(format:"%.0f", recipePreparationLabel) + "m"
    }
}
