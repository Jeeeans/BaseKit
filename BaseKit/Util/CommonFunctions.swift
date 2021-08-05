//
//  CommonFunctions.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/07/30.
//

import Foundation


public func classFromString<T>(_ className: String) -> T? {
    guard let infoDict = Bundle.main.infoDictionary,
          let nameSpcae = infoDict["CFBundleExecutable"] as? String,
          let cls = NSClassFromString("\(nameSpcae).\(className)") as? T else {
        return nil
    }
    
    return cls
}
