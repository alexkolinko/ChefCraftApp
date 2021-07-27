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
    
    // - Private properties
    private let constants: AppConstants.Constants = .init()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configUI()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.collectionRecipesImage.layer.cornerRadius = constants.cellImageCornerRadius
    }
    
    private func configUI() {
        backgroundCellView.backgroundColor = .clear
        collectionRecipesName.textColor =  .gray
        collectionRecipesName.font = constants.cellFontMetropolis
    }
    
    func configure(viewData: CollectionRecipes) {
        collectionRecipesName.text = viewData.title
        collectionRecipesImage.image = UIImage(named: "soup")
    }
}
