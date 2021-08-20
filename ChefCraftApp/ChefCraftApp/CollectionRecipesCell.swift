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
    private let constants: Constants = .init()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configUI()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.collectionRecipesImage.layer.cornerRadius = constants.cellImageCornerRadius
    }
    
    func configure(viewData: HomeViewContent.CategoryCellItem) {
        collectionRecipesName.text = viewData.title
        collectionRecipesImage.image = UIImage(named: viewData.image)
    }
}

// MARK: - Private logic
private extension CollectionRecipesCell {
    
    func configUI() {
        backgroundCellView.backgroundColor = .white
        collectionRecipesName.textColor = .gray
        collectionRecipesName.font = constants.cellFontMetropolis
    }
}

// MARK: - Internal constants
private extension CollectionRecipesCell {
    
    struct Constants {
        let cellImageCornerRadius: CGFloat = 20
        let cellFontMetropolis = AppFonts.Metropolis.regular.font(size: 12)
    }
}
