//
//  UIScreen+Base.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/08/12.
//

import UIKit

public extension UIScreen {
    static var screenWidth: CGFloat {
        return main.bounds.width
    }
    
    static var screenHeight: CGFloat {
        return main.bounds.height
    }
}
