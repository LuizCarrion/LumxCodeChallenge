//
//  HomeViewModel.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 08/03/24.
//

import Foundation

protocol HomeViewNavigationDelegate: AnyObject {
  func navigateToDetails(model: Movie)
}

protocol HomeViewModelProtocol {
  func loadUpcomingMovies()
}

class HomeViewModel: HomeViewModelProtocol {
  var upcomingMovies: Movies = []
  var popularMovies: Movies = []
  var service: NetworkService?
  
  weak var delegate: HomeViewControllerDelegate?
  weak var navigation: HomeViewNavigationDelegate?

  init(service: NetworkService? = nil,
       navigation: HomeViewNavigationDelegate? = nil) {
    self.service = service
    self.navigation = navigation
  }

  func loadUpcomingMovies() {
    service?.request(HomeRequest(), completion: { [weak self] result in
      guard let self = self else { return }

      switch result {
        case .success(let response):
          self.upcomingMovies = response.results
          self.delegate?.updateCollectionView()
        case .failure(let error):
          self.delegate?.displayError(error)
          print(error)
      }
    })
  }
}
