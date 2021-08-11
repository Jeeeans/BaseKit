//
//  UIView+Base.swift
//  BaseKit
//
//  Created by 진성준 on 2021/08/11.
//

import UIKit

public extension UIView {
    func cornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = false
    }
}
