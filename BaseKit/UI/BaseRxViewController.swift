//
//  BaseRxViewController.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/06/21.
//

import UIKit

open class BaseRxViewController<T: BaseRxViewModel>: UIViewController {
    open var viewModel: T!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialize()
    }
    
    open func initialize() {
        
    }
    
    
    open func viewModelBind(_ viewModel: T) {
        self.viewModel = viewModel
        
    }

}



