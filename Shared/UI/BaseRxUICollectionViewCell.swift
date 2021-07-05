//
//  BaseRxUICollectionViewCell.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/06/22.
//

import Foundation
import UIKit
import RxSwift

protocol RxCollectionViewCellAdaptable: AnyObject {
    associatedtype Model: Decodable
    
    static func size(_ model: Model) -> CGSize
    func configure(_ model: Model)
}

public class BaseRxUICollectionViewCell<T: Decodable>: UICollectionViewCell {
    
    
}