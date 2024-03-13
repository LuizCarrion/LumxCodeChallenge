//
//  HomeViewModel.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 08/03/24.
//

import Foundation

//MARK: - NavigationDelegate

protocol HomeViewNavigationDelegate: AnyObject {
  func navigateToDetails(model: Movie)
}

//MARK: - Protocol

protocol HomeViewModelProtocol {
  var upcomingMovies: Movies { get }
  var popularMovies: Movies { get }
  func loadUpcomingMovies()
  func generateImageUrl(path: String?) -> String
}

class HomeViewModel: HomeViewModelProtocol {

  //MARK: - Properties

  var upcomingMovies: Movies = []
  var popularMovies: Movies = []
  var service: NetworkService?
  let baseUrl: String = "https://image.tmdb.org/t/p/w500/"
  
  weak var delegate: HomeViewControllerDelegate?
  weak var navigation: HomeViewNavigationDelegate?

  //MARK: - Init

  init(service: NetworkService? = nil,
       navigation: HomeViewNavigationDelegate? = nil) {
    self.service = service
    self.navigation = navigation
  }

  func generateImageUrl(path: String?) -> String {
    guard let path else { return "" }
    return baseUrl + path
  }


  func filterUpcomingMovies() {
    guard popularMovies.count > 0 else { return }
    upcomingMovies = popularMovies
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    upcomingMovies.sort {
      guard let date0 = dateFormatter.date(from: $0.releaseDate ?? ""),
            let date1 = dateFormatter.date(from: $1.releaseDate ?? "") else { return false }
      
      return date0 < date1
    }
  }

  //MARK: - Request

  func loadUpcomingMovies() {
    service?.request(HomeRequest(), completion: { [weak self] result in
      guard let self = self else { return }

      switch result {
        case .success(let response):
          self.popularMovies = response.results ?? []
          filterUpcomingMovies()
          self.delegate?.updateCollectionView()
        case .failure(let error):
          self.delegate?.displayError(error: error)
          print(error)
      }
    })
  }
}
