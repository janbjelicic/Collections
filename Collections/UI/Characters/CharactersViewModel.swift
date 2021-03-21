//
//  CharactersViewModel.swift
//  Collections
//
//  Created by Jan Bjelicic on 19/03/2021.
//

import Foundation

class CharactersViewModel {
    
    let service: CharactersServiceProtocol
    private(set) var data: [CharacterViewModel] = []
    
    init(service: CharactersServiceProtocol) {
        self.service = service
    }
    
    func fetchCharacters(completion: @escaping (Result<Void, Error>) -> Void) {
        service.getCharacters { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let characters):
                print(characters)
                self.data = []
                let humans = characters.filter { character in
                    character.race == .human
                }
                self.data.append(CharacterViewModel(race: .human, characters: humans))
                let elves = characters.filter { character in
                    character.race == .elf
                }
                self.data.append(CharacterViewModel(race: .elf, characters: elves))
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
