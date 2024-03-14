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
    let viewModel = HomeViewModel(service: service, navigation: self)
    let viewController = HomeViewController(viewModel: viewModel)
    navigationController.pushViewController(viewController, animated: false)
  }

  override func finish() {
    removeAllChildCoordinators()
  }
}

//MARK: - HomeNavigation

extension MainCoordinator: HomeViewNavigationDelegate {
  func navigateToDetails(movie: Movie) {
    let viewModel = MovieDetailsViewModel(movie: movie, service: service)
    let viewController = MovieDetailsViewController(viewModel: viewModel)

    navigationController.pushViewController(viewController, animated: true)
  }
}
