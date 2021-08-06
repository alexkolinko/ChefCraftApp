//
//  RecipeDetailsViewController.swift
//  ChefCraftApp
//
//  Created by Work on 29.07.2021.
//

import RxCocoa
import RxSwift
import RxDataSources

class RecipeDetailsViewController: UIViewController, StoryboardInitializable {
    
    // - Outlets
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    // - Internal properties
    var presenter: RecipeDetailsPresenter!
    
    // - Private properties
    private let constants: Constants = .init()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.configBinding()
    }
    
    // - UI Setup
    private func configUI() {
        self.configCollectionView()
        self.configNavigationView()
    }
    
    // - Binding Setup
    private func configBinding() {
        
        let viewData = presenter.viewDataPublisher
            .observe(on: MainScheduler.instance)
        
        viewData
            .asObservable()
            .ignoreNil()
            .map { [$0.content.sectionModel] }
            .bind(to: contentCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewData
            .asObservable()
            .ignoreNil()
            .map { $0.imageHeader }
            .subscribe (onNext: { [weak self] image in
                self?.configureParalaxHeader(image)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func configNavigationView() {
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
    
    private func configureParalaxHeader(_ imageString: String) {
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
    
    // - Selectors
    @objc
    private func closeButton() {
        self.presenter.popView()
    }
}

extension RecipeDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = self.presenter.viewDataPublisher.value?.content.sectionModel.items[indexPath.row] else {
            return .zero
        }
        return item.calculateItemSize(width: collectionView.frame.width)
    }
}

extension RecipeDetailsViewController {
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatableSection<RecipeDetailsOverviewContentBox>>
    var dataSource: DataSource {
        return .init(configureCell: { _, collectionView, indexPath, item -> UICollectionViewCell in
            
            switch item {
            case .header(item: let item):
                let cell: RecipeHeaderCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.setModel(item)
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

private extension RecipeDetailsViewController {
    
    // MARK: - Internal constants
    struct Constants {
        let backButtonImage = UIImage(named: "backButton")
        let backButtonBackgroundColor: UIColor = .white.withAlphaComponent(0.2)
        let backButtonFrame = CGRect(x: 0, y: 0, width: 34, height: 34)
        let parallaxHeaderHeight: CGFloat = 312.0
    }
}
