//
//  BaseRxUICollectionViewCell.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/06/22.
//

import Foundation
import UIKit
import RxSwift

public protocol RxCollectionViewCellAdaptable: AnyObject {
    associatedtype Model
    
    static func size(_ model: Model) -> CGSize
    func configure(_ model: Model)
}
open class BaseRxUICollectionViewCell<T: Decodable>: UICollectionViewCell {
    static func size(_ model: Decodable) -> CGSize {
        fatalError("size function must be implemented")
    }
}
