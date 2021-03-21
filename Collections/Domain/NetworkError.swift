//
//  NetworkError.swift
//  Collections
//
//  Created by Jan Bjelicic on 20/03/2021.
//

import Foundation

enum NetworkError: Error {
    
    case invalidResponse
    case parsingError(String?)
    
}
