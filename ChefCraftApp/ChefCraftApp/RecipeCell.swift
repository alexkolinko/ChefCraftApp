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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configUI()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.recipeImage.layer.cornerRadius = 20
    }
    
    private func configUI() {
        
        recipeImage.clipsToBounds = true
        backgroundCellView.backgroundColor = .clear
        
        recipeName.textColor =  .gray
        recipeName.font = UIFont(name: "Metropolis", size: 12.0)
        
        recipeDescription.textColor =  .lightGray
        recipeDescription.font = UIFont(name: "Metropolis", size: 12.0)
    }
    
    func configure(viewData: ChefCraftOverviewViewData.Recipes) {
        recipeImage.image = UIImage(named: "bitmap")
        recipeName.text = viewData.title
        recipeDescription.text = viewData.description
    }
}
