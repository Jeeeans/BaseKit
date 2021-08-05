//
//  String+Base.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/06/21.
//

public extension String {
    func addQueryParameter(key: String, value: String) -> String {
        var urlString = self
        if urlString.contains("?") {
            urlString.append(contentsOf: "&\(key)=\(value)")
        } else {
            urlString.append(contentsOf: "?\(key)=\(value)")
        }
        
        return urlString
    }
}


