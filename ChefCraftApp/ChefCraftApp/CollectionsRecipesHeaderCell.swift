//
//  CollectionsRecipesHeaderCell.swift
//  ChefCraftApp
//
//  Created by Work on 26.07.2021.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

final class CollectionsRecipesHeaderCell: UICollectionViewCell, CellInizializable {
    
    // - Outlets
    @IBOutlet weak var collectionsRecipesCollectionView: UICollectionView!
    
    // - Internal properties
    let selectedCategory = BehaviorRelay<HomeViewContent.CategoryCellItem?>(value: nil)
    
    // - Private properties
    private let constants: Constants = .init()
    private(set) var disposeBag = DisposeBag()
    private let collectionRecipes = BehaviorRelay<[AnimatableSection<HomeViewContent.CategoryCellItem>]>(value: [])
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        self.setupBinding()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.setupBinding()
    }
    
    func configure(viewData: HomeViewContent.CategoriesSection) {
        self.collectionRecipes.accept([.init(items: viewData.categories)])
    }
}

// MARK: - Private logic
private extension CollectionsRecipesHeaderCell {
    
    func setupUI() {
        self.setupCollectionView()
    }
    
    func setupCollectionView() {
        self.collectionsRecipesCollectionView.delegate = self
        self.collectionsRecipesCollectionView.backgroundColor = .clear
        self.collectionsRecipesCollectionView.registerNib(CollectionRecipesCell.self)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = constants.layoutMinimumInteritemSpacing
        layout.minimumLineSpacing = constants.layoutMinimumLineSpacing
        self.collectionsRecipesCollectionView.collectionViewLayout = layout
    }
    
    func setupBinding() {
        self.disposeBag = DisposeBag()
        
        self.collectionRecipes
            .bind(to: self.collectionsRecipesCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        self.collectionsRecipesCollectionView.rx.modelSelected(HomeViewContent.CategoryCellItem.self)
            .bind(to: self.selectedCategory)
            .disposed(by: self.disposeBag)
    }
}

// MARK: - CollectionsRecipesHeaderCell: UICollectionViewDelegateFlowLayout
extension CollectionsRecipesHeaderCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: constants.collectionsRecipesHeaderCellWidth, height: constants.collectionsRecipesHeaderCellHeight)
    }
}

// MARK: - RxCollectionViewSectionedAnimatedDataSource
extension CollectionsRecipesHeaderCell {
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatableSection<HomeViewContent.CategoryCellItem>>
    
    var dataSource: DataSource {
        return .init(configureCell: { _, collectionView, indexPath, item -> UICollectionViewCell in
            let cell: CollectionRecipesCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(viewData: item)
            return cell
        })
    }
}

// MARK: - Internal constants
private extension CollectionsRecipesHeaderCell {
    
    struct Constants {
        let layoutMinimumInteritemSpacing: CGFloat = 6.0
        let layoutMinimumLineSpacing: CGFloat = 12.0
        let collectionsRecipesHeaderCellHeight: CGFloat = 180
        let collectionsRecipesHeaderCellWidth: CGFloat = 144
    }
}
