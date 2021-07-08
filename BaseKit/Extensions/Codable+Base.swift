//
//  Codable+Base.swift
//  BaseKit
//
//  Created by Sungjun Chin on 2021/06/22.
//

import Foundation
import Alamofire

extension Encodable {
    func toParameters() -> Parameters? {
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(self)
            let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String:Any]
            return dictionary
        } catch {
            Log.e(error)
        }
        return nil
    }
    
    func toString() -> String? {
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(self)
            let jsonString = String(data: jsonData, encoding: .utf16)
            return jsonString
        } catch {
            Log.e(error)
        }
        
        return nil
    }
}
