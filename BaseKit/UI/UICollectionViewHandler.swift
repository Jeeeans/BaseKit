//
//  UICollectionViewHandler.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/08/12.
//

import UIKit

//protocol UICollectionViewHandlerProtocol: RxCollectionViewAdaptable {
//    
//}
//
//public class UICollectionViewHandler: UICollectionViewHandlerProtocol {
//    public typealias Adapter = <#type#>
//    
//    
//}
//
//public extension UICollectionViewHandler: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return useSection ? adapter.count : 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if useSection, let model = adapter.item(section) as? [Decodable] {
//            return model.count
//        }
//        
//        return adapter.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return adapter.size(indexPath)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = adapter.getCell(indexPath) else { return UICollectionViewCell() }
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//    }
//}
