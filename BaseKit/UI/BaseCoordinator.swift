//
//  BaseCoordinator.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/07/29.
//

import Foundation
import UIKit

public protocol Coordinatable: AnyObject {
    var navigation: BaseNavigationController { get set }
}

extension Coordinatable {
    func push(_ viewController: UIViewController, _ animated: Bool) {
        navigation.pushViewController(viewController, animated: animated)
    }
    
    func pop(_ viewController: UIViewController, _ animated: Bool) {
        navigation.popViewController(animated: animated)
    }
    
    func goHome(_ animated: Bool) {
        navigation.popToRootViewController(animated: animated)
    }
}

public class BaseCoordinator {
    
}
