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
    
    // - Private properties
    private(set) var disposeBag = DisposeBag()
    private let collectionRecipes = BehaviorRelay<[AnimatableSection<CollectionRecipes>]>(value: [])
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        self.setupBinding()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.setupBinding()
    }
    
    func configure(viewData: ChefCraftOverviewViewData.CollectionsRecipesHeader) {
        self.collectionRecipes.accept([.init(items: viewData.collectionsRecipes)])
    }
}

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
        layout.minimumInteritemSpacing = 6.0
        layout.minimumLineSpacing = 12.0
        self.collectionsRecipesCollectionView.collectionViewLayout = layout
    }
    
    func setupBinding() {
        self.disposeBag = DisposeBag()
        
        self.collectionRecipes
            .bind(to: self.collectionsRecipesCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

// MARK: - CollectionsRecipesHeaderCell: UICollectionViewDelegateFlowLayout
extension CollectionsRecipesHeaderCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 180
        let width: CGFloat = 144
        return CGSize(width: width, height: height)
    }
}

// MARK: - RxCollectionViewSectionedAnimatedDataSource
extension CollectionsRecipesHeaderCell {
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatableSection<CollectionRecipes>>
    
    var dataSource: DataSource {
        return .init(configureCell: { _, collectionView, indexPath, item -> UICollectionViewCell in
            let cell: CollectionRecipesCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(viewData: item)
            return cell
        })
    }
}
