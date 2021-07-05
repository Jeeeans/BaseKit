//
//  RXCollectionViewAdaptable.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/07/01.
//

import UIKit


protocol RxCollectionViewAdaptable: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var collectionView: UICollectionView { get set }
    var useSection: Bool { get set }
    var adapter: BaseRxAdapter { get set }
    
    
}


extension RxCollectionViewAdaptable {
    func getSectionModel(_ section: Int) -> Decodable? {
        return adapter.item(section)
    }
    
    func adapterListCount() -> Int {
        return adapter.count
    }
    
    
    func cellFromAdapter<T: Decodable>(indexPath: IndexPath) -> BaseRxUICollectionViewCell<T> {
        return (adapter as RxAdapterAdaptable<T>).getCellFromIndex(indexPath)
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
        return collectionView.dequeueReusableCell(fromClass: cellFromAdapter(), for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(fromClass: cellFromAdapter(), for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
