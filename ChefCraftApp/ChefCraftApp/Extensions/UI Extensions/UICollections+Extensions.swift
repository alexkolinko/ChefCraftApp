//
//  UICollections+Extensions.swift
//  ChefCraftApp
//
//  Created by Work on 26.07.2021.
//

import UIKit

extension UICollectionView {
    func registerNib<T: CellInizializable>(_: T.Type) {
        register(
            T.nib,
            forCellWithReuseIdentifier: T.identifier
        )
    }
    
    func registerNibHeader<T: CellInizializable>(_: T.Type) {
        register(
            T.nib,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: T.identifier
        )
    }
    
    func registerNibFooter<T: CellInizializable>(_: T.Type) {
        register(
            T.nib,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: T.identifier
        )
    }
    
    func registerClass<T: CellInizializable & UICollectionViewCell>(_: T.Type) {
        register(
            T.self,
            forCellWithReuseIdentifier: T.identifier
        )
    }
    
    func dequeueReusableCell<T: CellInizializable>(forIndexPath indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T
        else { fatalError("Could not dequeue cell with identifier: \(T.identifier)") }
        
        return cell
    }
    
    func dequeueReusableSupplementaryView<T: CellInizializable>(forIndexPath indexPath: IndexPath, kind: String) -> T {
        guard
            let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.identifier, for: indexPath) as? T
        else { fatalError("Could not dequeue cell with identifier: \(T.identifier)") }
        
        return view
    }
    
    var centerPoint: CGPoint {
        CGPoint(
            x: center.x + contentOffset.x,
            y: center.y + contentOffset.y
        )
    }
    
    var indexPathInCenter: IndexPath? {
        indexPathForItem(at: centerPoint)
    }
}

extension UITableView {
    func registerNib<T: CellInizializable>(_: T.Type) {
        register(
            T.nib,
            forCellReuseIdentifier: T.identifier
        )
    }
    
    func registerClass<T: CellInizializable & UITableViewCell>(_: T.Type) {
        register(
            T.self,
            forCellReuseIdentifier: T.identifier
        )
    }
    
    func dequeueReusableCell<T: CellInizializable>(forIndexPath indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T
        else { fatalError("Could not dequeue cell with identifier: \(T.identifier)") }
        
        return cell
    }
}
