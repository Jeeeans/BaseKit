//
//  UIColor+Base.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/08/12.
//

import UIKit

public extension UIColor {
    
    convenience init(hex: String) {
        var code = hex
        if code.starts(with: "#") {
            code.removeFirst()
        }
        
        guard let rgb = Int(code) else {
            self.init(rgb: 0)
            return
        }
        
        self.init(rgb: rgb)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
        
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF)
        
    }
}
