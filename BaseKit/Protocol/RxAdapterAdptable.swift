//
//  BaseRxAdapter.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/07/01.
//

import Foundation
import UIKit
import RxSwift
import RxRelay
import RxCocoa

public protocol RxAdapterAdaptable: AnyObject {
    var adapter: BaseRxCollectionViewAdapter { get set }
    
    
    func setCellWithModel()
    
}

public extension RxAdapterAdaptable {
    
}
