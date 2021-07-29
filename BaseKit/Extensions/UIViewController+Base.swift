//
//  UIViewController+Base.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/07/29.
//

import Foundation
import UIKit

public extension UIViewController {
    static func initFromNib() -> Self {
        
        func instance<T: UIViewController>() -> T {
            return T(nibName: String(describing: self), bundle: nil)
        }
        
        return instance()
    }
}
