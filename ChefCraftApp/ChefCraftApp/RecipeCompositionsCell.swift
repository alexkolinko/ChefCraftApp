//
//  RecipeCompositionsCell.swift
//  ChefCraftApp
//
//  Created by Work on 02.08.2021.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

class RecipeCompositionsCell: UICollectionViewCell, CellInizializable {
    
    @IBOutlet weak var compositionsCollectionView: UICollectionView!
    
    // - Private properties
    private let constants: Constants = .init()
    private(set) var disposeBag = DisposeBag()
    private let compositions = BehaviorRelay<[AnimatableSection<RecipeCompositionCellModel>]>(value: [])
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
        self.setupBinding()
    }
    
    func configure(viewData: RecipeDetailsViewContent.CompositionsSection) {
        self.compositions.accept([.init(items: viewData.compositions)])
    }
    
}

private extension RecipeCompositionsCell {
    
    func setupUI() {
        self.setupCollectionView()
    }
    
    
    func setupCollectionView() {
        self.compositionsCollectionView.delegate = self
        self.compositionsCollectionView.backgroundColor = .clear
        self.compositionsCollectionView.registerNib(CompositionCell.self)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = constants.layoutMinimumInteritemSpacing
        layout.minimumLineSpacing = constants.layoutMinimumLineSpacing
        self.compositionsCollectionView.collectionViewLayout = layout
    }
    
    func setupBinding() {
        self.disposeBag = DisposeBag()
        
        self.compositions
            .bind(to: self.compositionsCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    
}

// MARK: - RecipeCompositionsCell: UICollectionViewDelegateFlowLayout
extension RecipeCompositionsCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: constants.compositionCellWidth, height: constants.compositionCellHeight)
    }
}

// MARK: - RxCollectionViewSectionedReloadDataSource
extension RecipeCompositionsCell {
    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatableSection<RecipeCompositionCellModel>>
    
    var dataSource: DataSource {
        return .init(configureCell: { _, collectionView, indexPath, item -> UICollectionViewCell in
            let cell: CompositionCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(model: item)
            return cell
        })
    }
}

private extension RecipeCompositionsCell {
    
    // MARK: - Internal constants
    struct Constants {
        let layoutMinimumInteritemSpacing: CGFloat = 6.0
        let layoutMinimumLineSpacing: CGFloat = 12.0
        let compositionCellHeight: CGFloat = 50
        let compositionCellWidth: CGFloat = 110
    }
}
