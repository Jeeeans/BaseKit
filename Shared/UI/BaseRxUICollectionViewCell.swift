//
//  BaseRxUICollectionViewCell.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/06/22.
//

import Foundation
import UIKit
import RxSwift

public protocol BaseRxUICollectionViewCell: UICollectionViewCell {
    associatedtype Model: Decodable
    
    static var size: CGSize { get set }
    func configure(_ model: Model)
}
