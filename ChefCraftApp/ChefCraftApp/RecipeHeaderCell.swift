//
//  RecipeHeaderCell.swift
//  ChefCraftApp
//
//  Created by Work on 02.08.2021.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftEntryKit

class RecipeHeaderCell: UICollectionViewCell, CellInizializable {
    
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeOwner: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var backgraundView: UIView!
    @IBOutlet weak var likeButton: UIButton!
    
    // - Internal properties
    let selectedRating = PublishRelay<Void>()
    let selectedLike = BehaviorRelay<Bool?>(value: nil)
    let isLike = BehaviorRelay<Bool?>(value: nil)
    let rating = BehaviorRelay<Int?>(value: nil)
    
    // - Private properties
    private(set) var bag = DisposeBag()
    private let constants: Constants = .init()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configUI()
        self.configBinding()
    }
    
    // - Internal Logic
    func setModel(_ model: RecipeDetailsViewContent.HeaderSection) {
        self.recipeTitle.text = model.title
        self.recipeOwner.text = AppStrings.Recipe.chef + model.owner
        self.ratingControl.rating.accept(model.stars)
        self.likeButton.rx.isSelected.onNext(model.isLike)
    }
}

// MARK: - Private logic
private extension RecipeHeaderCell {
   
    func configUI() {
        self.likeButton.setImage(self.constants.selectedHeartImage, for: .selected)
        self.likeButton.setImage(self.constants.unselectedHeartImage, for: .normal)
        self.recipeTitle.font = self.constants.fontMetropolisBold
        self.recipeOwner.font = self.constants.fontMetropolisLight
        self.backgraundView.layer.cornerRadius = 20
    }
    
    func configBinding() {
        self.likeButton.rx
            .tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.likeAction()
            })
            .disposed(by: self.bag)
        
        self.ratingControl.ratingTapped
            .bind(to: self.selectedRating)
            .disposed(by: self.bag)
        
        self.isLike
            .asObservable()
            .ignoreNil()
            .bind(to: self.likeButton.rx.isSelected)
            .disposed(by: self.bag)
        
        self.rating
            .asObservable()
            .ignoreNil()
            .bind(to: self.ratingControl.rating)
            .disposed(by: self.bag)
    }
    
    func likeAction() {
        self.selectedLike.accept(!self.likeButton.isSelected)
    }
}

// MARK: - Internal constants
private extension RecipeHeaderCell {
    
    struct Constants {
        
        // - Icons
        let unselectedHeartImage = AppImages.icHeart.image
        let selectedHeartImage = AppImages.icRedHeart.image
        
        // - Fonts
        let fontMetropolisBold = UIFont(name: "Metropolis-Bold", size: 18.0)
        let fontMetropolisLight = UIFont(name: "Metropolis-Light", size: 10.0)
    }
}
