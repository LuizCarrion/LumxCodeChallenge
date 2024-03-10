//
//  MainCoordinator.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 08/03/24.
//

import UIKit

class MainCoordinator: Coordinator {
  var navigationController: UINavigationController
  let service: DefaultNetworkService = DefaultNetworkService()

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  override func start() {
    let viewModel = HomeViewModel()
    let viewController = HomeViewController()
    navigationController.pushViewController(viewController, animated: false)
  }

  override func finish() {
    removeAllChildCoordinators()
  }
}
