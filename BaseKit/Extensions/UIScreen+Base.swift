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
    
    static var topNotchHeight: CGFloat {
        return UIWindow.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    
    static var bottomNotchHeight: CGFloat {
        return UIWindow.keyWindow?.safeAreaInsets.bottom ?? (isNotchScreen ? 34 : 0)
    }
    
    static var isNotchScreen: Bool {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            let height = UIScreen.main.nativeBounds.height
            
            switch height {
                
            case 1136:          // iPhone 5 or 5S or 5C
                return false
                
            case 1334:          // iPhone 6/6S/7/8
                return false
                
            case 1920, 2208:    // iPhone 6+/6S+/7+/8+
                return false
                
            case 2436:          // iPhone X, Xs
                return true
                
            case 2688:          // iPhone Xs Max, 11 Pro Max
                return true
                
            case 1792:          // iPhone Xr, 11
                return true
                
            case 2778:          // iPhone 12 Pro Max
                return true
                
            case 2532:          // iPhone 12, 12 Pro
                return true
                
            case 2340:          // iPhone 12 mini
                return true
                
            default:
                return false
                
            }
        }

        return false
    }
}
