//
//  RXCollectionViewAdaptable.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/07/01.
//

import UIKit


public protocol RxCollectionViewAdaptable: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    associatedtype Adapter : BaseRxCollectionViewAdapter
    var collectionView: UICollectionView! { get set }
    var useSection: Bool { get set }
    var adapter: Adapter { get set }
}

extension RxCollectionViewAdaptable {
    func getSectionModel(_ section: Int) -> Decodable? {
        return adapter.item(section)
    }
    
    func adapterListCount() -> Int {
        return adapter.count
    }
    
    func cellFromAdapter(indexPath: IndexPath) -> UICollectionViewCell? {
        return adapter.getCell(indexPath)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return useSection ? adapter.count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if useSection, let model = adapter.item(section) as? [Decodable] {
            return model.count
        }
        
        return adapter.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return adapter.size(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = adapter.getCell(indexPath) else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
