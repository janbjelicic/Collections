//
//  CharactersService.swift
//  Collections
//
//  Created by Jan Bjelicic on 19/03/2021.
//

import Foundation

protocol CharactersServiceProtocol {
    func getCharacters(completion: @escaping (Result<[Character], Error>) -> ())
}

struct CharactersData: Decodable {
    
    let docs: [Character]
    
}

class CharactersService: CharactersServiceProtocol {
    
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getCharacters(completion: @escaping (Result<[Character], Error>) -> ()) {
        let request = CharactersRequest(limit: 50)
        networkManager.request(urlRequest: request) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(CharactersData.self, withJSONObject: data)
                    completion(.success(response.docs))
                } catch (let error) {
                    completion(.failure(NetworkError.parsingError(error.localizedDescription)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
