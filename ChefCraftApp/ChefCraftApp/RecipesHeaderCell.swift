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
    private(set) var disposeBag = DisposeBag()
    private let recipes = BehaviorRelay<[AnimatableSection<ChefCraftOverviewViewData.Recipes>]>(value: [])
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        self.setupBinding()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.setupBinding()
    }
    
    func configure(viewData: ChefCraftOverviewViewData.RecipesHeader) {
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
        layout.minimumInteritemSpacing = 6.0
        layout.minimumLineSpacing = 12.0
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
        let height: CGFloat = 350
        let width: CGFloat = 280
        return CGSize(width: width, height: height)
    }
}

// MARK: - RxCollectionViewSectionedReloadDataSource
extension RecipesHeaderCell {
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatableSection<ChefCraftOverviewViewData.Recipes>>
    
    var dataSource: DataSource {
        return .init(configureCell: { _, collectionView, indexPath, item -> UICollectionViewCell in
            let cell: RecipeCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(viewData: item)
            return cell
        })
    }
}
