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
    
    // - Private properties
    private let constants: AppConstants.Constants = .init()
    private(set) var disposeBag = DisposeBag()
    private let recipes = BehaviorRelay<[AnimatableSection<Recipe>]>(value: [])
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        self.setupBinding()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.setupBinding()
    }
    
    func configure(viewData: ChefCraftOverviewViewData.MainRecipesSection) {
        self.recipes.accept([.init(items: viewData.recipesHeader)])
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
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatableSection<Recipe>>
    
    var dataSource: DataSource {
        return .init(configureCell: { _, collectionView, indexPath, item -> UICollectionViewCell in
            let cell: RecipeCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(viewData: item)
            return cell
        })
    }
}
