//
//  UIWindow+Base.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/10/28.
//

import Foundation
import UIKit

public extension UIWindow {
    static var keyWindow: UIWindow? {
        return UIApplication.shared.windows.first { $0.isKeyWindow }
    }
}
