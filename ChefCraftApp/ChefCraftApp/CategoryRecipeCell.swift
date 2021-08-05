//
//  CategoryRecipeCell.swift
//  ChefCraftApp
//
//  Created by Work on 04.08.2021.
//

import UIKit

class CategoryRecipeCell: UITableViewCell, CellInizializable {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeDescription: UILabel!
    
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
    }
    
    private func configUI() {
        self.recipeImage.layer.cornerRadius = constants.cellImageCornerRadius
        self.recipeName.textColor = .black
        self.recipeName.font = constants.cellFontMetropolisBold
        self.recipeDescription.textColor = .gray
    }
    
}

private extension CategoryRecipeCell {
    
    // MARK: - Internal constants
    struct Constants {
        let cellImageCornerRadius: CGFloat = 10
        let cellFontMetropolisBold = UIFont(name: "Metropolis-Bold", size: 15.0)
        let cellFontMetropolisLight = UIFont(name: "Metropolis", size: 13.0)
    }
}
