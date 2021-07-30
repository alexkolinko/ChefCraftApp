//
//  HomeViewController.swift
//  ChefCraftApp
//
//  Created by Work on 23.07.2021.
//

import RxCocoa
import RxSwift
import RxDataSources

class HomeViewController: UIViewController, StoryboardInitializable {

    // - Outlets
    @IBOutlet weak var contentCollection: UICollectionView!
    
    // - Internal properties
    var presenter: HomePresenter!

    // - Private properties
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.configBinding()
    }

    // - UI Setup
    private func configUI() {
        configCollectionView()
    }

    // - Binding Setup
    private func configBinding() {
        let viewData = presenter.viewDataPublisher
            .observe(on: MainScheduler.instance)
        
        viewData
            .asObservable()
            .ignoreNil()
            .map { [$0.sectionModel] }
            .bind(to: contentCollection.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    func configCollectionView() {
        contentCollection.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        self.contentCollection.collectionViewLayout = layout
        self.contentCollection.backgroundColor = .clear
        contentCollection.registerNib(CollectionsRecipesHeaderCell.self)
        contentCollection.registerNib(RecipesHeaderCell.self)
        contentCollection.alwaysBounceVertical = true
        contentCollection.showsVerticalScrollIndicator = false
    }
}


extension HomeViewController {
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatableSection<ChefCraftOverviewContentBox>>
    
    var dataSource: DataSource {
        return .init(configureCell: { _, collectionView, indexPath, item -> UICollectionViewCell in

            switch item {
            case .collectionsRecipesHeader(let item):
                let cell: CollectionsRecipesHeaderCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.configure(viewData: item)
                return cell
            case .recipesHeader(item: let item):
                let cell: RecipesHeaderCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.configure(viewData: item)
                cell.selectedRecipe
                    .subscribe (onNext: { [weak self] recipe in
                        guard let recipe = recipe else { return }
                        self?.presenter.selectCell(model: recipe)
                    })
                    .disposed(by: self.disposeBag)

                return cell
            }
        })
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = self.presenter.viewDataPublisher.value?.sectionModel.items[indexPath.row] else {
            return .zero
        }
        return item.calculateItemSize(width: collectionView.frame.width)
    }
}
