//
//  AppCoordinator.swift
//  Collections
//
//  Created by Jan Bjelicic on 19/03/2021.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    func showCharacterDetails(character: Character)
}

class AppCoordinator: AppCoordinatorProtocol {
    
    var navigationController: UINavigationController
    var childrenCoordinators: [Coordinator] = []
    private let window: UIWindow
    
    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func start() {
        guard let charactersViewController = R.storyboard.main.charactersViewControllerID() else { return }
        let networkManager = NetworkManager()
        let charactersService = CharactersService(networkManager: networkManager)
        let charactersViewModel = CharactersViewModel(coordinator: self, service: charactersService)
        charactersViewController.configure(viewModel: charactersViewModel)
        navigationController.pushViewController(charactersViewController, animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    // Shows the characters screen.
    func showCharacterDetails(character: Character) {
        guard let characterDetailsViewController = R.storyboard.main.characterDetailViewControllerID() else { return }
        let characterDetailsViewModel = CharacterDetailsViewModel(character: character)
        characterDetailsViewController.configure(viewModel: characterDetailsViewModel)
        navigationController.pushViewController(characterDetailsViewController, animated: true)
    }
    
}

