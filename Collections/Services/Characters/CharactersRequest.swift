//
//  CharactersRequest.swift
//  Collections
//
//  Created by Jan Bjelicic on 19/03/2021.
//

import Foundation

struct CharactersRequest: Encodable {
    
    let limit: Int
    
}

extension CharactersRequest: NetworkRequest {
    
    var method: HttpVerb { .get }
    
    var path: String { "character" }
    
    var parameters: [String : Any]? { ["limit": limit] }
    
}
