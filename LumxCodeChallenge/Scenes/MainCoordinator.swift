//
//  MainCoordinator.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 08/03/24.
//

import UIKit

protocol Coordinator {
  var childCoordinators: [Coordinator] { get set }
  var navigationController: UINavigationController { get set }

  func start()
}

class MainCoordinator: Coordinator {
  var childCoordinators = [Coordinator]()
  var navigationController: UINavigationController
  let service: DefaultNetworkService = DefaultNetworkService()

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let viewModel = HomeViewModel()
    let viewController = HomeViewController()
    navigationController.pushViewController(viewController, animated: false)
  }
}
