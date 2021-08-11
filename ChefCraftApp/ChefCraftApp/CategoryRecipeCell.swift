//
//  CategoryRecipeCell.swift
//  ChefCraftApp
//
//  Created by Work on 04.08.2021.
//

import UIKit
import RxDataSources

class CategoryRecipeCell: UITableViewCell, CellInizializable {
    
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
    func setModel(_ model: CategoryRecipeCellModel) {
        self.recipeImage.image = UIImage(named: model.model.image)
        self.recipeName.text = model.model.name
        self.recipeDescription.text = model.model.description
        self.ratingControl.rating.accept(model.model.stars)
        self.recipeOwner.text = "by \(model.model.owner)"
    }
}

// MARK: - Private logic
private extension CategoryRecipeCell {
    
    func configUI() {
        self.configShadowContainer()
        self.ratingControl.isUserInteractionEnabled = false
        self.recipeImage.layer.cornerRadius = constants.cellImageCornerRadius
        self.recipeName.textColor = .black
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
private extension CategoryRecipeCell {
    
    struct Constants {
        let cellImageCornerRadius: CGFloat = 10
        let cellFontMetropolisBold = UIFont(name: "Metropolis-Bold", size: 15.0)
        let cellFontMetropolis = UIFont(name: "Metropolis", size: 13.0)
    }
}

extension CategoryRecipeCell {
    struct Model: IdentifiableType {
        /// JSON data of ChefCraftRecipe
        var data: Recipe
        
        var identity: String {
            return "\(data.id)"
        }
    }
}

extension CategoryRecipeCell.Model: Equatable {
    
    static func == (lhs: CategoryRecipeCell.Model, rhs: CategoryRecipeCell.Model) -> Bool {
        return lhs.identity == rhs.identity
    }
}
