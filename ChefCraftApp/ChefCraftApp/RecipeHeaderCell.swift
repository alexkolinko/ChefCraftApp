//
//  RecipeHeaderCell.swift
//  ChefCraftApp
//
//  Created by Work on 02.08.2021.
//

import UIKit
import RxCocoa
import RxSwift

class RecipeHeaderCell: UICollectionViewCell, CellInizializable {
    
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeOwner: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var backgraundView: UIView!
    
    // - Internal properties
    let selectedRating = BehaviorRelay<Int?>(value: nil)
    
    // - Private properties
    private(set) var bag = DisposeBag()
    private let constants: Constants = .init()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configUI()
        
        self.ratingControl.rating
            .bind(to: self.selectedRating)
            .disposed(by: self.bag)
    }
    
    // - Internal Logic
    func setModel(_ model: RecipeDetailsViewContent.HeaderSection) {
        self.recipeTitle.text = model.title
        self.recipeOwner.text = "by \(model.owner)"
        self.ratingControl.rating.accept(model.stars)
    }
    
    private func configUI() {
        self.recipeTitle.font = constants.cellFontMetropolisBold
        self.recipeOwner.font = constants.cellFontMetropolis
        self.backgraundView.layer.cornerRadius = 20
    }
    

}

private extension RecipeHeaderCell {
    
    // MARK: - Internal constants
    struct Constants {
        let cellFontMetropolisBold = UIFont(name: "Metropolis-Bold", size: 18.0)
        let cellFontMetropolis = UIFont(name: "Metropolis-Light", size: 10.0)
    }
}
