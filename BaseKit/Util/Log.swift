//
//  Log.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/06/21.
//

import Foundation
import Logging

enum LogType: String {
    case debug = "DEBUG"
    case error = "ERROR"
    case info = "INFO"
}

public class Log {
    
    static func getClassName() -> String {
        let type = type(of: self)
        let name = String(describing: type.self)
        return name
    }
    
    static func d(_ message: String?) {
        guard let message = message else { return }
        Log.print(message, type: .debug)
    }
    
    static func d(_ object: Any?) {
        guard let object = object else { return }
        Log.print(object, type: .debug)
    }
    
    static func e(_ message: String?) {
        guard let message = message else { return }
        Log.print(message, type: .error)
    }
    
    static func e(_ object: Any?) {
        guard let object = object else { return }
        Log.print(object, type: .error)
    }
    
    static func i(_ message: String?) {
        guard let message = message else { return }
        Log.print(message, type: .info)
    }
    
    static func i(_ object: Any?) {
        guard let object = object else { return }
        Log.print(object, type: .info)
    }
    
    static func print(_ message: String, type: LogType) {
        Swift.print("[\(Date().timeIntervalSinceNow)] \(type.rawValue): \(Log.getClassName()) : \(String(describing: message))")
    }
    
    static func print(_ object: Any, type: LogType) {
        Swift.print("[\(Date().timeIntervalSinceNow)] \(type.rawValue): \(Log.getClassName()) : \(object))")
    }
}
