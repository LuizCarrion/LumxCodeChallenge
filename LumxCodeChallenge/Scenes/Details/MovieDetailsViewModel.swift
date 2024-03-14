//
//  MovieDetailsViewModel.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 13/03/24.
//

import Foundation

protocol MovieDetailsViewModelProtocol: AnyObject {
  var details: MovieDetails? { get }
  var credits: CreditsResponse? { get }
  var baseUrl: String { get }
  var delegate: MovieDetailsViewControllerDelegate? { get set }
  func getDetails()
  func getCredits()
  func generateImageUrl(path: String?) -> String
}

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {

  let service: NetworkService?
  var details: MovieDetails?
  var credits: CreditsResponse?
  let movie: Movie
  let baseUrl: String = "https://image.tmdb.org/t/p/w500/"

  weak var delegate: MovieDetailsViewControllerDelegate?

  init(movie: Movie,
       service: NetworkService? = nil) {
    self.movie = movie
    self.service = service
  }

  func generateImageUrl(path: String?) -> String {
    guard let path else { return "" }
    return baseUrl + path
  }

  func getDetails() {
    guard let movieId = movie.id else { return }
    service?.request(MovieDetailsRequest(path: String(movieId)), completion: { [weak self] result in
      guard let self = self else { return }
      DispatchQueue.main.async {
        switch result {
          case .success(let response):
            self.details = response
            self.delegate?.updateView()
          case .failure(let error):
            print(error)
        }
      }
    })
  }

  func getCredits() {
    guard let movieId = movie.id else { return }
    service?.request(CastDetailsRequest(path: String(movieId)), completion: { [weak self] result in
      guard let self = self else { return }
      DispatchQueue.main.async {
        switch result {
          case .success(let response):
            self.credits = response
            self.delegate?.updateCollectionView()
          case .failure(let error):
            print(error)
        }
      }
    })
  }
}
