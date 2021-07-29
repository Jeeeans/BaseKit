//
//  BaseNavigationController.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/07/29.
//

import Foundation
import UIKit

open class BaseNavigationController: UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    }
}

extension BaseNavigationController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        
    }
}
