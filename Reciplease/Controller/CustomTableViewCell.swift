//
//  CustomTableViewCell.swift
//  Reciplease
//
//  Created by Elie Arquier on 03/03/2020.
//  Copyright © 2020 Elie Arquier. All rights reserved.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
// MARK: - Outlets and property
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var recipeLikeLabel: UILabel!
    @IBOutlet weak var recipePreparationLabel: UILabel!

    /// Instance of ApiImageService
    var apiService = ApiImageService()

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

        apiService.getImage(imageUrl: recipeImage) { (success, data) in
            if success {
                guard let data = data else { return }

                self.recipeImage.image = UIImage(data:data) ?? UIImage(named: "default")!
                
            } else {
                self.recipeImage.image = UIImage(named: "default")!
            }
        }

        // Display data in custom cell labels and image
        //self.recipeImage.image = test(recipeImage: recipeImage)
        self.recipeLabel.text = recipeLabel
        self.ingredientsLabel.text = ingredientsLabel
        self.recipeLikeLabel.text = recipeLikeLabel
        self.recipePreparationLabel.text = String(format:"%.0f", recipePreparationLabel) + " m"
    }
}
