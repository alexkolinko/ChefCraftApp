//
//  RecipesHeaderCell.swift
//  ChefCraftApp
//
//  Created by Work on 26.07.2021.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

final class RecipesHeaderCell: UICollectionViewCell, CellInizializable {
    
    // - Outlets
    @IBOutlet weak var recipesCollectionView: UICollectionView!
    
    // - Internal properties
    let selectedRecipe = BehaviorRelay<HomeViewContent.RecipeCellItem?>(value: nil)
    
    // - Private properties
    private let constants: Constants = .init()
    private(set) var disposeBag = DisposeBag()
    private let recipes = BehaviorRelay<[AnimatableSection<HomeViewContent.RecipeCellItem>]>(value: [])
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        self.setupBinding()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.setupBinding()
    }
    
    func configure(viewData: HomeViewContent.RecipesSection) {
        self.recipes.accept([.init(items: viewData.recipes)])
    }
}

private extension RecipesHeaderCell {
    
    func setupUI() {
        self.setupCollectionView()
    }
    
    func setupCollectionView() {
        self.recipesCollectionView.delegate = self
        self.recipesCollectionView.backgroundColor = .clear
        self.recipesCollectionView.registerNib(RecipeCell.self)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = constants.layoutMinimumInteritemSpacing
        layout.minimumLineSpacing = constants.layoutMinimumLineSpacing
        self.recipesCollectionView.collectionViewLayout = layout
    }
    
    func setupBinding() {
        self.disposeBag = DisposeBag()
        
        self.recipes
            .bind(to: self.recipesCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        self.recipesCollectionView.rx
            .modelSelected(HomeViewContent.RecipeCellItem.self)
            .bind(to: self.selectedRecipe)
            .disposed(by: self.disposeBag)
    }
}

// MARK: - RecipesHeaderCell: UICollectionViewDelegateFlowLayout
extension RecipesHeaderCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: constants.recipesHeaderCellWidth, height: constants.recipesHeaderCellHeight)
    }
}

// MARK: - RxCollectionViewSectionedReloadDataSource
extension RecipesHeaderCell {
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatableSection<HomeViewContent.RecipeCellItem>>
    
    var dataSource: DataSource {
        return .init(configureCell: { _, collectionView, indexPath, item -> UICollectionViewCell in
            let cell: RecipeCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(viewData: item)
            return cell
        })
    }
}

private extension RecipesHeaderCell {
    
    // MARK: - Internal constants
    struct Constants {
        let layoutMinimumInteritemSpacing: CGFloat = 6.0
        let layoutMinimumLineSpacing: CGFloat = 12.0
        let recipesHeaderCellHeight: CGFloat = 350
        let recipesHeaderCellWidth: CGFloat = 280
    }
}
