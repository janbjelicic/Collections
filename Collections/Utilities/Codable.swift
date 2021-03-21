//
//  Codable.swift
//  Collections
//
//  Created by Jan Bjelicic on 20/03/2021.
//

import Foundation

extension JSONDecoder {
    func decode<T: Decodable>(_: T.Type, withJSONObject object: Any, options opt: JSONSerialization.WritingOptions = []) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: object, options: opt)
        return try decode(T.self, from: data)
    }
}
