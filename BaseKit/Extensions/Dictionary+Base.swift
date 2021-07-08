//
//  Dictionary+Base.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/06/21.
//

extension Dictionary {
    func toString() -> [String:String] {
        var dicToString: [String:String] = [:]
        
        self.forEach { key, value in
            dicToString[String(describing: key)] = String(describing: value)
        }
        
        return dicToString
    }
}
