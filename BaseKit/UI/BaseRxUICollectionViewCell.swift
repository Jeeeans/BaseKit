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

public class BaseRxUICollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: self)
    
    static func size(_ model: Decodable) -> CGSize {
        return .zero
    }
}
