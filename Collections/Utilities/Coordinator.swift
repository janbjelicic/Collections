//
//  Coordinator.swift
//  Collections
//
//  Created by Jan Bjelicic on 19/03/2021.
//

import UIKit

protocol Coordinator: class {
    var navigationController: UINavigationController { get set }
    var childrenCoordinators: [Coordinator] { get set }
    func start()
}
