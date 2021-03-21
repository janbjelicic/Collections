//
//  CharactersViewModel.swift
//  Collections
//
//  Created by Jan Bjelicic on 19/03/2021.
//

import Foundation

struct CharactersViewData {
    
    let race: CharacterRace
    let characters: [Character]
    
}

class CharactersViewModel {
    
    let service: CharactersServiceProtocol
    weak var coordinator: AppCoordinatorProtocol?
    
    private(set) var data: [CharactersViewData] = []
    
    init(coordinator: AppCoordinatorProtocol, service: CharactersServiceProtocol) {
        self.coordinator = coordinator
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
                self.data.append(CharactersViewData(race: .human, characters: humans))
                let elves = characters.filter { character in
                    character.race == .elf
                }
                self.data.append(CharactersViewData(race: .elf, characters: elves))
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
