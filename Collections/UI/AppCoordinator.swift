//
//  AppCoordinator.swift
//  Collections
//
//  Created by Jan Bjelicic on 19/03/2021.
//

import UIKit

class AppCoordinator: Coordinator {
    
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
        let charactersViewModel = CharactersViewModel(service: charactersService)
        charactersViewController.configure(viewModel: charactersViewModel)
        navigationController.pushViewController(charactersViewController, animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}

