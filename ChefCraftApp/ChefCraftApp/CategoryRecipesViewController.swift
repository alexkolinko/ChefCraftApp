//
//  CategoryRecipesViewController.swift
//  ChefCraftApp
//
//  Created by Work on 04.08.2021.
//

import RxCocoa
import RxSwift
import RxDataSources

class CategoryRecipesViewController: UIViewController, StoryboardInitializable {
    
    // - Outlets
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var recipesTable: UITableView!
    
    // - Internal properties
    var presenter: CategoryRecipesPresenter!
    
    // - Private properties
    private let constants: Constants = .init()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configUI()
        self.configBinding()
    }
    
    // - UI Setup
    private func configUI() {
        self.configNavigationView()
        self.setUpTableView()
    }
    
    // - Binding Setup
    private func configBinding() {
        
        let viewData = presenter.viewData
            .observe(on: MainScheduler.instance)
        
        viewData.asObservable()
            .ignoreNil()
            .map { $0.categoryRecipesDataSource }
            .asDriver(onErrorJustReturn: [])
            .drive(self.recipesTable.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
        
        viewData.asObservable()
            .ignoreNil()
            .map { $0.imageCategory }
            .subscribe(onNext: { [weak self] image in
                self?.categoryImage.image = UIImage(named: image)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func setUpTableView() {
        self.recipesTable.rowHeight = UITableView.automaticDimension
        self.recipesTable.estimatedRowHeight = constants.estimatedRowHeight
        self.recipesTable.registerNib(CategoryRecipeCell.self)
        self.recipesTable.backgroundColor = .white
        self.recipesTable.separatorStyle = .none
        self.recipesTable.alwaysBounceVertical = true
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
    
    // - Selectors
    @objc
    private func closeButton() {
        self.presenter.popView()
    }
}

// MARK: - RxCollectionViewSectionedAnimatedDataSource
extension CategoryRecipesViewController {
    
    typealias DataSource = RxTableViewSectionedAnimatedDataSource<CategoryRecipesSectionModel>
    
    var dataSource: DataSource {
        let configuration = AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .fade)
        return .init(
            animationConfiguration: configuration,
            configureCell: { _, tableView, indexPath, item -> UITableViewCell in
                let cell: CategoryRecipeCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.setModel(item)
                return cell
            }
        )
    }
}

private extension CategoryRecipesViewController {
    
    struct Constants {
        
        // - Geometry
        let estimatedRowHeight: CGFloat = 96.0
        let backButtonFrame = CGRect(x: 0, y: 0, width: 34, height: 34)
        
        // - Icons
        let backButtonImage = UIImage(named: "backButton")
        
        // - Colors
        let backButtonBackgroundColor: UIColor = .white.withAlphaComponent(0.2)
        
    }
}
