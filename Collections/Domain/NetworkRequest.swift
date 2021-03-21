//
//  NetworkRequest.swift
//  Collections
//
//  Created by Jan Bjelicic on 19/03/2021.
//

import Foundation

enum HttpVerb: String {
    
    case get = "GET"
    
}

protocol NetworkRequest {
    
    var method: HttpVerb { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    
}

extension NetworkRequest {
    
    private var baseUrl: String {
        "https://the-one-api.dev/v2/"
    }
    
    private var url: URL? {
        guard var urlComponents = URLComponents(string: baseUrl) else { return nil }
        urlComponents.path += path
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
    
    private var queryItems: [URLQueryItem]? {
        guard method == .get, let parameters = parameters else { return nil }
        var items = [URLQueryItem]()
        for (key, value) in parameters {
            items.append(URLQueryItem(name: key, value: String(describing: value)))
        }
        return items
    }
    
    func getRequest() -> URLRequest? {
        guard let url = url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
    
        urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer Y3tnYMe0ffLWhV77ue9B",
                                          "Content-Type" : "application/json"]
        return urlRequest
    }
    
    
    
}
