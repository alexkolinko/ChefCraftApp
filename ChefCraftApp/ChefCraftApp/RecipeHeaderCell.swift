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
    let selectedRating = BehaviorRelay<Int?>(value: nil)
    let selectedLike = BehaviorRelay<Bool?>(value: nil)
    
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
        
        self.likeButton.setImage(model.isLike ? self.constants.selectedHeartImage : self.constants.unselectedHeartImage, for: .normal)
        
    }
}

// MARK: - Private logic
private extension RecipeHeaderCell {
   
    func configUI() {
        self.recipeTitle.font = self.constants.fontMetropolisBold
        self.recipeOwner.font = self.constants.fontMetropolisLight
        self.backgraundView.layer.cornerRadius = 20
    }
    
    func configBinding() {
        self.ratingControl.ratingTapped
            .subscribe(onNext: { [weak self] _ in
                self?.showRatingView()
            })
            .disposed(by: self.bag)
        
        self.likeButton.rx
            .tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.likeButtonAction()
            })
            .disposed(by: self.bag)
    }
    
    func likeButtonAction() {
        if self.likeButton.imageView?.image == self.constants.unselectedHeartImage {
            self.likeButton.setImage(self.constants.selectedHeartImage, for: .normal)
            self.selectedLike.accept(true)
            self.showFloatView(title: self.constants.floatLikeTitle, description: self.constants.floatLikeDescription, image: self.constants.selectedHeartImage)
        } else {
            self.likeButton.setImage(self.constants.unselectedHeartImage, for: .normal)
            self.selectedLike.accept(false)
            self.showFloatView(title: self.constants.floatRemovedLikeTitle, description: self.constants.floatRemovedLikeDescription, image: self.constants.unselectedHeartImage)
        }
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
        
        guard let metropolisFont = self.constants.fontMetropolis else { return }
        let unselectedImage = EKProperty.ImageContent(
            image: self.constants.unselectedStarImage!.withRenderingMode(.alwaysTemplate),
            displayMode: .light,
            tint: .standardContent
        )
        let selectedImage = EKProperty.ImageContent(
            image: self.constants.selectedStarImage!.withRenderingMode(.alwaysTemplate),
            displayMode: .light,
            tint: EKColor.ratingStar
        )
        let initialTitle = EKProperty.LabelContent(
            text: self.constants.ratingTitleText,
            style: .init(
                font: metropolisFont,
                color: .standardContent,
                alignment: .center,
                displayMode: EKAttributes.DisplayMode.inferred
            )
        )
        let initialDescription = EKProperty.LabelContent(
            text: self.constants.ratingDescriptionText,
            style: .init(
                font: metropolisFont,
                color: EKColor.standardContent.with(alpha: 0.5),
                alignment: .center,
                displayMode: EKAttributes.DisplayMode.inferred
            )
        )
        let items = self.constants.ratingMessageItems.map { texts -> EKProperty.EKRatingItemContent in
                        let itemTitle = EKProperty.LabelContent(
                            text: texts.0,
                            style: .init(
                                font: metropolisFont,
                                color: .standardContent,
                                alignment: .center,
                                displayMode: EKAttributes.DisplayMode.inferred
                            )
                        )
                        let itemDescription = EKProperty.LabelContent(
                            text: texts.1,
                            style: .init(
                                font: metropolisFont,
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
        let lightFont = metropolisFont
        let mediumFont = metropolisFont
        let closeButtonLabelStyle = EKProperty.LabelStyle(
            font: mediumFont,
            color: .standardContent,
            displayMode: EKAttributes.DisplayMode.inferred
        )
        let closeButtonLabel = EKProperty.LabelContent(
            text: self.constants.ratingCloseButtonText,
            style: closeButtonLabelStyle
        )
        let closeButton = EKProperty.ButtonContent(
            label: closeButtonLabel,
            backgroundColor: .clear,
            highlightedBackgroundColor: EKColor.standardBackground.with(alpha: 0.2),
            displayMode: EKAttributes.DisplayMode.inferred) {
            SwiftEntryKit.dismiss()
        }
        let greenColor = EKColor.green
        let okButtonLabelStyle = EKProperty.LabelStyle(
            font: lightFont,
            color: greenColor,
            displayMode: EKAttributes.DisplayMode.inferred
        )
        let okButtonLabel = EKProperty.LabelContent(
            text: self.constants.ratingOkButtonText,
            style: okButtonLabelStyle
        )
        let okButton = EKProperty.ButtonContent(
            label: okButtonLabel,
            backgroundColor: .clear,
            highlightedBackgroundColor: greenColor.with(alpha: 0.05),
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
    
    // Show float view
    func showFloatView(title: String, description: String, image: UIImage?) {
        var attributes = EKAttributes.topFloat
        attributes.entryBackground = .color(color: EKColor.black.with(alpha: 0.7))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3), scale: .init(from: 1, to: 0.7, duration: 0.7)))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10, offset: .zero))
        attributes.statusBar = .dark
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.positionConstraints.size = .init(width: .offset(value: 20), height: .intrinsic)

        guard let metropolisFont = constants.fontMetropolis else { return }
        let title = EKProperty.LabelContent(text: title, style: .init(font: metropolisFont, color: EKColor.white))
        let description = EKProperty.LabelContent(text: description, style: .init(font: metropolisFont, color: EKColor.white))
        let image = EKProperty.ImageContent(image: image!, size: CGSize(width: 35, height: 35))
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
}

// MARK: - Internal constants
private extension RecipeHeaderCell {
    
    struct Constants {
        let floatLikeDescription = "Recipe added to your favorite."
        let floatRemovedLikeDescription = "Recipe removed from your favorite."
        let floatLikeTitle = "Like!"
        let floatRemovedLikeTitle = "Removed like!"
        let ratingCloseButtonText = "Dismiss"
        let ratingOkButtonText = "Accept"
        let ratingDescriptionText = "How was it?"
        let ratingTitleText = "Rate our food"
        let selectedStarImage = UIImage(named: "ic_star_selected")
        let unselectedStarImage = UIImage(named: "ic_star_unselected")
        let unselectedHeartImage = UIImage(named: "icHeart")
        let selectedHeartImage = UIImage(named: "icRedHeart")
        let fontMetropolis = UIFont(name: "Metropolis", size: 13.0)
        let fontMetropolisBold = UIFont(name: "Metropolis-Bold", size: 18.0)
        let fontMetropolisLight = UIFont(name: "Metropolis-Light", size: 10.0)
        let ratingMessageItems = [("💩", "Pooish!"), ("🤨", "Ahhh?!"), ("👍", "OK!"),
                                 ("👌", "Tasty!"), ("😋", "Delicius!")]
    }
}
