//
//  CompositionCell.swift
//  ChefCraftApp
//
//  Created by Work on 02.08.2021.
//

import UIKit

class CompositionCell: UICollectionViewCell, CellInizializable {

    @IBOutlet weak var backgraundView: UIView!
    @IBOutlet weak var compositionType: UILabel!
    @IBOutlet weak var compositionValue: UILabel!
    
    // - Private properties
    private let constants: Constants = .init()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configUI()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let borderCollor: UIColor = .lightGray
        self.backgraundView.backgroundColor = .clear
        self.backgraundView.layer.cornerRadius = constants.backgraundCornerRadius
        self.backgraundView.layer.borderColor = borderCollor.cgColor
        self.backgraundView.layer.borderWidth = constants.borderWidth
    }
    
    func configure(model: RecipeDetailsViewContent.CompositionCellItem) {
        compositionType.text = model.type.title
        compositionValue.text = "\(model.value) \(model.type.unit)"
    }
}

// MARK: - Private logic
private extension CompositionCell {
    
    private func configUI() {
        compositionType.textColor =  .gray
        compositionType.font = constants.cellFontMetropolis
        
        compositionValue.textColor =  .black
        compositionValue.font = constants.cellFontMetropolis
    }
}

// MARK: - Internal constants
private extension CompositionCell {
    
    struct Constants {
        let backgraundCornerRadius: CGFloat = 10
        let cellFontMetropolis = UIFont(name: "Metropolis", size: 12.0)
        let borderWidth: CGFloat = 0.5
    }
}
