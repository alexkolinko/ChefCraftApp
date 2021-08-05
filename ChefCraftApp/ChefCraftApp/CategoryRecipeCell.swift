//
//  CategoryRecipeCell.swift
//  ChefCraftApp
//
//  Created by Work on 04.08.2021.
//

import UIKit

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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // - Internal Logic
    func setModel(_ model: CategoryRecipeCellModel) {
        self.recipeImage.image = UIImage(named: model.model.image)
        self.recipeName.text = model.model.name
        self.recipeDescription.text = model.model.description
        self.ratingControl.rating = model.model.stars
        self.recipeOwner.text = "by \(model.model.owner)"
    }
    
    private func configUI() {
 
        self.configShadowContainer()
        self.ratingControl.isUserInteractionEnabled = false
        self.recipeImage.layer.cornerRadius = constants.cellImageCornerRadius
        self.recipeName.textColor = .black
        self.recipeName.font = constants.cellFontMetropolisBold
        self.recipeDescription.textColor = .gray
        self.recipeOwner.textColor = .gray
        self.recipeOwner.font = constants.cellFontMetropolis
    }
    
    private func configShadowContainer() {
        self.shadowContainer.dropShadow()
        shadowContainer.layer.cornerRadius = constants.cellImageCornerRadius
    }
    
}

private extension CategoryRecipeCell {
    
    // MARK: - Internal constants
    struct Constants {
        let cellImageCornerRadius: CGFloat = 10
        let cellFontMetropolisBold = UIFont(name: "Metropolis-Bold", size: 15.0)
        let cellFontMetropolis = UIFont(name: "Metropolis", size: 13.0)
    }
}
