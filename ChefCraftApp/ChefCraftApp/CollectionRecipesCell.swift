//
//  CollectionRecipesCell.swift
//  ChefCraftApp
//
//  Created by Work on 26.07.2021.
//

import UIKit

final class CollectionRecipesCell: UICollectionViewCell, CellInizializable {
    
    @IBOutlet weak var collectionRecipesName: UILabel!
    @IBOutlet weak var collectionRecipesImage: UIImageView!
    @IBOutlet weak var backgroundCellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configUI()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.collectionRecipesImage.layer.cornerRadius = 20
    }
    
    private func configUI() {
        backgroundCellView.backgroundColor = .clear
        collectionRecipesName.textColor =  .gray
        collectionRecipesName.font = UIFont(name: "Metropolis", size: 12.0)
    }
    
    func configure(viewData: CollectionRecipes) {
        collectionRecipesName.text = viewData.title
        collectionRecipesImage.image = UIImage(named: "soup")
    }
}
