//
//  ModuleResponsable.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/07/30.
//

import Foundation

public protocol ModuleResponsable: Codable, Hashable {
    var modules: [Module] { get set }
    func parseModules()
}

public extension ModuleResponsable {
    
}
