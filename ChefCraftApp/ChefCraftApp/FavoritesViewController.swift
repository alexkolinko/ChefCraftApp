//
//  FavoritesViewController.swift
//  ChefCraftApp
//
//  Created by Work on 11.08.2021.
//

import RxCocoa
import RxSwift
import RxDataSources
import TBEmptyDataSet

class FavoritesViewController: UIViewController, StoryboardInitializable {

    // - Outlets
    @IBOutlet weak var favoritesTable: UITableView!
    
    // - Internal properties
    var presenter: FavoritesPresenter!

    // - Private properties
    private let constants: Constants = .init()
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.configBinding()
    }
}

// MARK: - Private logic
private extension FavoritesViewController {
 
    // - UI Setup
    func configUI() {
        self.setUpNavigationBar()
        self.setUpTableView()
    }

    // - Binding Setup
    func configBinding() {
        let viewData = presenter.viewData
            .observe(on: MainScheduler.instance)
        
        viewData.asObservable()
            .ignoreNil()
            .map { $0.favoritesRecipesDataSource }
            .asDriver(onErrorJustReturn: [])
            .drive(self.favoritesTable.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
    }
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: AppColors.frenchGrey.color,
            .font: self.constants.fontMetropolisBold
        ]
        self.navigationItem.title = AppStrings.Favorites.Navigation.title
    }
    
    func setUpTableView() {
        self.favoritesTable.rowHeight = UITableView.automaticDimension
        self.favoritesTable.estimatedRowHeight = constants.estimatedRowHeight
        self.favoritesTable.registerNib(FavoriteCell.self)
        self.favoritesTable.emptyDataSetDelegate = self
        self.favoritesTable.emptyDataSetDataSource = self
        self.favoritesTable.backgroundColor = .white
        self.favoritesTable.separatorStyle = .none
        self.favoritesTable.alwaysBounceVertical = true
    }

}

// MARK: - RxCollectionViewSectionedAnimatedDataSource
extension FavoritesViewController {
    
    typealias DataSource = RxTableViewSectionedAnimatedDataSource<FavoritesSectionModel>
    
    var dataSource: DataSource {
        let configuration = AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .fade)
        return .init(
            animationConfiguration: configuration,
            configureCell: { _, tableView, indexPath, item -> UITableViewCell in
                let cell: FavoriteCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.setModel(item)
                return cell
            }
        )
    }
}

// MARK: - InAppPostsListViewController: TBEmptyDataSetDelegate, TBEmptyDataSetDataSource
extension FavoritesViewController: TBEmptyDataSetDelegate, TBEmptyDataSetDataSource {

    func titleForEmptyDataSet(in scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: AppStrings.Favorites.Data.Empty.title)
    }
    
    func emptyDataSetScrollEnabled(in scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func titleMarginForEmptyDataSet(in scrollView: UIScrollView) -> CGFloat {
        return self.constants.sizeTitleEmptyStyle
    }
}

// MARK: - Constants
private extension FavoritesViewController {
    
    struct Constants {
        let backButtonBackgroundColor: UIColor = .white.withAlphaComponent(0.2)
        let fontMetropolisBold = AppFonts.Metropolis.bold.font(size: 18.0)        
        // - Geometry
        let sizeTitleEmptyStyle: CGFloat = 24.0
        let estimatedRowHeight: CGFloat = 96.0
        let backButtonFrame = CGRect(x: 0, y: 0, width: 34, height: 34)
    }
}
