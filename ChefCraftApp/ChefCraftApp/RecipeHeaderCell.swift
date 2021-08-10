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
    
    // - Internal properties
    let selectedRating = BehaviorRelay<Int?>(value: nil)
    
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
        self.recipeOwner.text = "by \(model.owner)"
        self.ratingControl.rating.accept(model.stars)
    }
    
}

// MARK: - Private logic
private extension RecipeHeaderCell {
   
    func configUI() {
        self.recipeTitle.font = constants.cellFontMetropolisBold
        self.recipeOwner.font = constants.cellFontMetropolis
        self.backgraundView.layer.cornerRadius = 20
    }
    
    func configBinding() {
        self.ratingControl.ratingTapped
            .subscribe(onNext: { [weak self] _ in
                self?.showRatingView()
            })
            .disposed(by: self.bag)
        
    }
    
    // Show rating view
    func showRatingView() {
        var rating = 0
        var attributes = EKAttributes.centerFloat
        attributes.hapticFeedbackType = .success
        attributes.displayDuration = .infinity
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 8, offset: .zero))
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.roundCorners = .all(radius: 8)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.7, spring: .init(damping: 0.7, initialVelocity: 0)), scale: .init(from: 0.7, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.exitAnimation = .init(translate: .init(duration: 0.2))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.35)))
        attributes.positionConstraints.size = .init(width: .offset(value: 20), height: .intrinsic)
        attributes.screenBackground = .visualEffect(style: .standard)
        attributes.entryBackground = .visualEffect(style: .standard)
        
        guard let myFont = UIFont(name: "Metropolis", size: 13.0) else { return }
        
        
        let unselectedImage = EKProperty.ImageContent(
            image: UIImage(named: "ic_star_unselected")!.withRenderingMode(.alwaysTemplate),
            displayMode: .light,
            tint: .standardContent
        )
        let selectedImage = EKProperty.ImageContent(
            image: UIImage(named: "ic_star_unselected.imageset")!.withRenderingMode(.alwaysTemplate),
            displayMode: .light,
            tint: EKColor.ratingStar
        )
        let initialTitle = EKProperty.LabelContent(
            text: "Rate our food",
            style: .init(
                font: myFont,
                color: .standardContent,
                alignment: .center,
                displayMode: EKAttributes.DisplayMode.inferred
            )
        )
        let initialDescription = EKProperty.LabelContent(
            text: "How was it?",
            style: .init(
                font: myFont,
                color: EKColor.standardContent.with(alpha: 0.5),
                alignment: .center,
                displayMode: EKAttributes.DisplayMode.inferred
            )
        )
        let items = [("💩", "Pooish!"), ("🤨", "Ahhh?!"), ("👍", "OK!"),
                     ("👌", "Tasty!"), ("😋", "Delicius!")].map { texts -> EKProperty.EKRatingItemContent in
                        let itemTitle = EKProperty.LabelContent(
                            text: texts.0,
                            style: .init(
                                font: myFont,
                                color: .standardContent,
                                alignment: .center,
                                displayMode: EKAttributes.DisplayMode.inferred
                            )
                        )
                        let itemDescription = EKProperty.LabelContent(
                            text: texts.1,
                            style: .init(
                                font: myFont,
                                color: .standardContent,
                                alignment: .center,
                                displayMode: EKAttributes.DisplayMode.inferred
                            )
                        )
                        return EKProperty.EKRatingItemContent(
                            title: itemTitle,
                            description: itemDescription,
                            unselectedImage: unselectedImage,
                            selectedImage: selectedImage
                        )
                     }
        
        var message: EKRatingMessage!
        let lightFont = myFont
        let mediumFont = myFont
        let closeButtonLabelStyle = EKProperty.LabelStyle(
            font: mediumFont,
            color: .standardContent,
            displayMode: EKAttributes.DisplayMode.inferred
        )
        let closeButtonLabel = EKProperty.LabelContent(
            text: "Dismiss",
            style: closeButtonLabelStyle
        )
        let closeButton = EKProperty.ButtonContent(
            label: closeButtonLabel,
            backgroundColor: .clear,
            highlightedBackgroundColor: EKColor.standardBackground.with(alpha: 0.2),
            displayMode: EKAttributes.DisplayMode.inferred) {
            SwiftEntryKit.dismiss {
                // Here you may perform a completion handler
            }
        }
        
        let pinkyColor = EKColor.pinkyColor
        let okButtonLabelStyle = EKProperty.LabelStyle(
            font: lightFont,
            color: pinkyColor,
            displayMode: EKAttributes.DisplayMode.inferred
        )
        let okButtonLabel = EKProperty.LabelContent(
            text: "Accept",
            style: okButtonLabelStyle
        )
        let okButton = EKProperty.ButtonContent(
            label: okButtonLabel,
            backgroundColor: .clear,
            highlightedBackgroundColor: pinkyColor.with(alpha: 0.05),
            displayMode: EKAttributes.DisplayMode.inferred) { [weak self] in
            self?.ratingControl.rating.accept(rating)
            self?.selectedRating.accept(rating)
            SwiftEntryKit.dismiss()
        }
        let buttonsBarContent = EKProperty.ButtonBarContent(
            with: closeButton, okButton,
            separatorColor: EKColor(light: UIColor.lightGray, dark: UIColor.lightGray),
            horizontalDistributionThreshold: 1,
            displayMode: EKAttributes.DisplayMode.inferred,
            expandAnimatedly: true
        )
        message = EKRatingMessage(
            initialTitle: initialTitle,
            initialDescription: initialDescription,
            ratingItems: items,
            buttonBarContent: buttonsBarContent) { index in
            // Rating selected
            rating = index + 1
        }
        
        let contentView = EKRatingMessageView(with: message)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
}

// MARK: - Internal constants
private extension RecipeHeaderCell {
    
    struct Constants {
        let cellFontMetropolisBold = UIFont(name: "Metropolis-Bold", size: 18.0)
        let cellFontMetropolis = UIFont(name: "Metropolis-Light", size: 10.0)
    }
}
