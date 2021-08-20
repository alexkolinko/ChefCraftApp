//
//  RecipeCell.swift
//  ChefCraftApp
//
//  Created by Work on 26.07.2021.
//

import UIKit

final class RecipeCell: UICollectionViewCell, CellInizializable {
    
    // - Outlets
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeDescription: UILabel!
    
    // - Private properties
    private let constants: Constants = .init()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configUI()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.recipeImage.layer.cornerRadius = constants.cellImageCornerRadius
    }
    
    func configure(viewData: HomeViewContent.RecipeCellItem) {
        recipeImage.image = UIImage(named: viewData.image)
        recipeName.text = viewData.title
        recipeDescription.text = viewData.description
    }
}

// MARK: - Private logic
private extension RecipeCell {
    
    private func configUI() {
        recipeImage.clipsToBounds = true
        recipeName.textColor = .gray
        recipeName.font = constants.cellFontMetropolis
        recipeDescription.textColor = .lightGray
        recipeDescription.font = constants.cellFontMetropolis
    }
}

// MARK: - Internal constants
private extension RecipeCell {
    
    struct Constants {
        let cellImageCornerRadius: CGFloat = 20
        let cellFontMetropolis = AppFonts.Metropolis.regular.font(size: 12.0)
    }
}
