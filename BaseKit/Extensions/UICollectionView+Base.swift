//
//  UICollectionView+Base.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/07/01.
//

import UIKit

public extension UICollectionView {
    func register<T: UICollectionViewCell>(nibFromClass: T, at bundleClass: AnyClass? = nil) {
        let identifier = String(describing: T.self)
        var bundle: Bundle?
        
        if let bundleName = bundleClass { bundle = Bundle(for: bundleName)}
        
        register(UINib(nibName: identifier, bundle: bundle), forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(fromClass: T, for indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }
}
