//
//  FavoriteCell.swift
//  ChefCraftApp
//
//  Created by Work on 11.08.2021.
//

import UIKit
import RxDataSources

class FavoriteCell: UITableViewCell, CellInizializable {
    
    @IBOutlet weak var shadowContainer: UIView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeDescription: UILabel!
    @IBOutlet weak var recipeOwner: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    
    // - Private properties
    private let constants: Constants = .init()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configUI()
    }
    
    // - Internal Logic
    func setModel(_ model: FavoriteCellModel) {
        self.recipeImage.image = UIImage(named: model.model.image)
        self.recipeName.text = model.model.name
        self.recipeDescription.text = model.model.description
        self.ratingControl.rating.accept(model.model.stars)
        self.recipeOwner.text = AppStrings.Recipe.chef + model.model.owner
    }
}

// MARK: - Private logic
private extension FavoriteCell {
    
    func configUI() {
        self.configShadowContainer()
        self.ratingControl.isUserInteractionEnabled = false
        self.recipeImage.layer.cornerRadius = constants.cellImageCornerRadius
        self.recipeName.textColor = .gray
        self.recipeName.font = constants.cellFontMetropolisBold
        self.recipeDescription.textColor = .gray
        self.recipeOwner.textColor = .gray
        self.recipeOwner.font = constants.cellFontMetropolis
    }
    
    func configShadowContainer() {
        self.shadowContainer.dropShadow()
        shadowContainer.layer.cornerRadius = constants.cellImageCornerRadius
    }
}

// MARK: - Internal constants
private extension FavoriteCell {
    
    struct Constants {
        let cellImageCornerRadius: CGFloat = 10
        let cellFontMetropolisBold = AppFonts.Metropolis.bold.font(size: 15.0)
        let cellFontMetropolis = AppFonts.Metropolis.regular.font(size: 13.0)
    }
}

// MARK: - Internal models
extension FavoriteCell {
    struct Model: IdentifiableType {
        /// JSON data of ChefCraftRecipe
        var data: Recipe
        var identity: String {
            return "\(data.id)"
        }
    }
}

// MARK: - FavoriteCell.Model: Equatable
extension FavoriteCell.Model: Equatable {
    
    static func == (lhs: FavoriteCell.Model, rhs: FavoriteCell.Model) -> Bool {
        return lhs.identity == rhs.identity
    }
}
