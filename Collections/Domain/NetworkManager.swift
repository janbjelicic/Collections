//
//  NetworkManager.swift
//  Collections
//
//  Created by Jan Bjelicic on 19/03/2021.
//

import Foundation

protocol NetworkManagerProtocol {
    func request(urlRequest: NetworkRequest, completion: @escaping (Result<Any, Error>) -> ())
}

class NetworkManager: NetworkManagerProtocol {
    
    private let session = URLSession.shared
    
    func request(urlRequest: NetworkRequest, completion: @escaping (Result<Any, Error>) -> ()) {
        guard let request = urlRequest.getRequest() else {
            return
        }
        let task = session.dataTask(with: request) { data, urlResponse, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                completion(.success(json))
            } catch (let error) {
                completion(.failure(NetworkError.parsingError(error.localizedDescription)))
            }
        }
        task.resume()
    }
    
}
