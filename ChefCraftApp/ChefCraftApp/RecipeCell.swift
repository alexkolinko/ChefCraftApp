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
    @IBOutlet weak var backgroundCellView: UIView!
    
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
    
    private func configUI() {
        
        recipeImage.clipsToBounds = true
        backgroundCellView.backgroundColor = .clear
        
        recipeName.textColor = .gray
        recipeName.font = constants.cellFontMetropolis
        
        recipeDescription.textColor = .lightGray
        recipeDescription.font = constants.cellFontMetropolis
    }
    
    func configure(viewData: HomeViewContent.RecipeCellItem) {
        recipeImage.image = UIImage(named: viewData.image)
        recipeName.text = viewData.title
        recipeDescription.text = viewData.description
    }
}

private extension RecipeCell {
    
    // MARK: - Internal constants
    struct Constants {
        let cellImageCornerRadius: CGFloat = 20
        let cellFontMetropolis = UIFont(name: "Metropolis", size: 12.0)
    }
}
