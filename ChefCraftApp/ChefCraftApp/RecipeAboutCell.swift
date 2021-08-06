//
//  RecipeAboutCell.swift
//  ChefCraftApp
//
//  Created by Work on 02.08.2021.
//

import UIKit

class RecipeAboutCell: UICollectionViewCell, CellInizializable {

    
    @IBOutlet weak var aboutTitle: UILabel!
    @IBOutlet weak var aboutDescription: UILabel!
    
    // - Private properties
    private let constants: Constants = .init()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configUI()
    }
    
    // - Internal Logic
    func setModel(_ content: String) {
        self.aboutDescription.text = content
    }
    
    // - Private Properties
    private func configUI() {
        self.aboutTitle.font = constants.cellFontMetropolisBold
        self.aboutDescription.font = constants.cellFontMetropolis
    }
}

private extension RecipeAboutCell {
    
    // MARK: - Internal constants
    struct Constants {
        let cellFontMetropolisBold = UIFont(name: "Metropolis-Bold", size: 18.0)
        let cellFontMetropolis = UIFont(name: "Metropolis-Light", size: 10.0)
        let borderWidth: CGFloat = 0.5
    }
}
