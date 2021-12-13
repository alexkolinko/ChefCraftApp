//
//  RecipeDetailsViewController.swift
//  ChefCraftApp
//
//  Created by Work on 29.07.2021.
//

import RxCocoa
import RxSwift
import RxDataSources
import SwiftEntryKit

class RecipeDetailsViewController: UIViewController, StoryboardInitializable {
    
    // - Outlets
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    // - Internal properties
    var presenter: RecipeDetailsPresenterProtocol!
    
    // - Private properties
    private let constants: Constants = .init()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.configBinding()
    }
}

// MARK: - Private logic
extension RecipeDetailsViewController {
    
    // - UI Setup
    func configUI() {
        self.configCollectionView()
        self.configNavigationView()
    }
    
    // - Binding Setup
    func configBinding() {
        
        presenter.output.content
            .observe(on: MainScheduler.asyncInstance)
            .map { [$0.sectionModel] }
            .bind(to: contentCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        presenter.output.imageHeader
            .observe(on: MainScheduler.asyncInstance)
            .subscribe (onNext: { [weak self] image in
                self?.configureParalaxHeader(image)
            })
            .disposed(by: self.disposeBag)

        presenter.output.applyLikeAction
            .observe(on: MainScheduler.asyncInstance)
            .subscribe (onNext: { [weak self] value in
                self?.likeAction(value)
            })
            .disposed(by: self.disposeBag)
        
    }
    
    func configNavigationView() {
        let button = UIButton(type: .custom)
        button.frame = self.constants.backButtonFrame
        button.backgroundColor = self.constants.backButtonBackgroundColor
        button.setImage(self.constants.backButtonImage, for: .normal)
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = button.bounds.size.width / 2
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.closeButton), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: button)
        barButton.tintColor = .white
        self.navigationItem.setLeftBarButton(barButton, animated: true)
    }
    
    func configureParalaxHeader(_ imageString: String) {
        let image = UIImageView()
        image.image = UIImage(named: imageString)
        image.contentMode = .scaleAspectFill
        self.contentCollectionView.parallaxHeader.view = image
        self.contentCollectionView.parallaxHeader.height = self.constants.parallaxHeaderHeight
        self.contentCollectionView.parallaxHeader.minimumHeight = 0.0
        self.contentCollectionView.parallaxHeader.mode = .bottomFill
    }
    
    func configCollectionView() {
        contentCollectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        self.contentCollectionView.collectionViewLayout = layout
        self.contentCollectionView.backgroundColor = .clear
        contentCollectionView.registerNib(RecipeHeaderCell.self)
        contentCollectionView.registerNib(RecipeAboutCell.self)
        contentCollectionView.registerNib(RecipeCompositionsCell.self)
        contentCollectionView.alwaysBounceVertical = true
        contentCollectionView.showsVerticalScrollIndicator = false
    }
    
    func likeAction(_ value: Bool) {
        self.showFloatView(title: value ? self.constants.floatLikeTitle : self.constants.floatRemovedLikeTitle, description: value ? self.constants.floatLikeDescription : self.constants.floatRemovedLikeDescription, image: value ? self.constants.selectedHeartImage : self.constants.unselectedHeartImage)
    }
    
    // - Selectors
    @objc func closeButton() {
        self.presenter.input.onAction.onNext(.popView)
    }
}

// MARK: - RecipeDetailsViewController: UICollectionViewDelegateFlowLayout
extension RecipeDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = self.presenter.getItem(index: indexPath.row)
        else {
            return .zero
        }
        return item.calculateItemSize(width: collectionView.frame.width)
    }
}

// MARK: - RecipeDetailsViewController: RxCollectionViewSectionedAnimatedDataSource
extension RecipeDetailsViewController {
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatableSection<RecipeDetailsOverviewContentBox>>
    var dataSource: DataSource {
        return .init(configureCell: { [weak self] _, collectionView, indexPath, item -> UICollectionViewCell in
            
            switch item {
            case .header(item: let item):
                let cell: RecipeHeaderCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.setModel(item)
                
                cell.selectedRating
                    .subscribe (onNext: { [weak self] rating in
                        self?.showRatingView()
                    })
                    .disposed(by: cell.bag)

                cell.selectedLike
                    .asObservable()
                    .ignoreNil()
                    .observe(on: MainScheduler.asyncInstance)
                    .subscribe (onNext: { [weak self] isLike in
                        self?.presenter.input.onAction.onNext(.selectLike(isLike))
                    })
                    .disposed(by: cell.bag)
                
                cell.selectedCooked
                    .asObservable()
                    .ignoreNil()
                    .observe(on: MainScheduler.asyncInstance)
                    .subscribe (onNext: { [weak self] isCooked in
                        self?.presenter.input.onAction.onNext(.selectCooked(isCooked))
                    })
                    .disposed(by: cell.bag)
                
                self?.presenter.output.applyLikeAction
                    .observe(on: MainScheduler.asyncInstance)
                    .bind(to: cell.isLike)
                    .disposed(by: cell.bag)
                
                self?.presenter.output.applyCookedAction
                    .observe(on: MainScheduler.asyncInstance)
                    .bind(to: cell.isCooked)
                    .disposed(by: cell.bag)
                
                self?.presenter.output.applyRatingSelected
                    .observe(on: MainScheduler.asyncInstance)
                    .bind(to: cell.rating)
                    .disposed(by: cell.bag)
                
                return cell
            case .compositions(item: let item):
                let cell: RecipeCompositionsCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.configure(viewData: item)
                return cell
            case .about(item: let item):
                let cell: RecipeAboutCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.setModel(item.about)
                return cell
            }
        })
    }
}

// MARK: - SwiftEntryKit views
private extension RecipeDetailsViewController {
    
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
                font: self.constants.fontMetropolis,
                color: .standardContent,
                alignment: .center,
                displayMode: EKAttributes.DisplayMode.inferred
            )
        )
        let initialDescription = EKProperty.LabelContent(
            text: self.constants.ratingDescriptionText,
            style: .init(
                font: self.constants.fontMetropolis,
                color: EKColor.standardContent.with(alpha: 0.5),
                alignment: .center,
                displayMode: EKAttributes.DisplayMode.inferred
            )
        )
        let items = self.constants.ratingMessageItems.map { texts -> EKProperty.EKRatingItemContent in
            let itemTitle = EKProperty.LabelContent(
                text: texts.0,
                style: .init(
                    font: self.constants.fontMetropolis,
                    color: .standardContent,
                    alignment: .center,
                    displayMode: EKAttributes.DisplayMode.inferred
                )
            )
            let itemDescription = EKProperty.LabelContent(
                text: texts.1,
                style: .init(
                    font: self.constants.fontMetropolis,
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
        let lightFont = self.constants.fontMetropolis
        let mediumFont = self.constants.fontMetropolis
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
                self?.presenter.input.onAction.onNext(.selectRating(rating))
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
        
        let title = EKProperty.LabelContent(text: title, style: .init(font: constants.fontMetropolis, color: EKColor.white))
        let description = EKProperty.LabelContent(text: description, style: .init(font: constants.fontMetropolis, color: EKColor.white))
        let image = EKProperty.ImageContent(image: image!, size: CGSize(width: 35, height: 35))
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
}

// MARK: - Internal constants
private extension RecipeDetailsViewController {
    
    struct Constants {
        
        // - Colors
        let backButtonBackgroundColor: UIColor = .white.withAlphaComponent(0.2)
        
        // - Geometry
        let backButtonFrame = CGRect(x: 0, y: 0, width: 34, height: 34)
        let parallaxHeaderHeight: CGFloat = 312.0
        
        // - Texts
        let floatLikeDescription = "Recipe added to your favorite."
        let floatRemovedLikeDescription = "Recipe removed from your favorite."
        let floatLikeTitle = "Like!"
        let floatRemovedLikeTitle = "Removed like!"
        let ratingCloseButtonText = "Dismiss"
        let ratingOkButtonText = "Accept"
        let ratingDescriptionText = "How was it?"
        let ratingTitleText = "Rate our food"
        let ratingMessageItems = [("💩", "Pooish!"), ("🤨", "Ahhh?!"), ("👍", "OK!"),
                                  ("👌", "Tasty!"), ("😋", "Delicius!")]
        
        // - Icons
        let backButtonImage = UIImage(named: "backButton")
        let selectedStarImage = UIImage(named: "ic_star_selected")
        let unselectedStarImage = UIImage(named: "ic_star_unselected")
        let unselectedHeartImage = UIImage(named: "icHeart")
        let selectedHeartImage = UIImage(named: "icRedHeart")

        // - Fonts
        let fontMetropolis = UIFont(name: "Metropolis", size: 13.0) ?? UIFont.systemFont(ofSize: 13)
        let fontMetropolisBold = UIFont(name: "Metropolis-Bold", size: 18.0) ?? UIFont.systemFont(ofSize: 18)
        let fontMetropolisLight = UIFont(name: "Metropolis-Light", size: 10.0) ?? UIFont.systemFont(ofSize: 10)
    }
}
