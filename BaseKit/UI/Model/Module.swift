//
//  Module.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/08/02.
//

import Foundation

public struct Module: Codable {
    var type: String!
    var model: Decodable!
    
    public static func == (lhs: Module, rhs: Module) -> Bool {
        if lhs.type == rhs.type {
            return true
        }
        
        return false
    }
    
    enum CodingKeys: CodingKey {
        case type, model
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let decoded = try decoder.container(keyedBy: CodingKeys.self)
            type = try decoded.decode(String.self, forKey: .type)
            
            switch type {
            case "":
                break
            default:
                break
            }
        } catch {
            Log.e(error)
        }
    }
    
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
