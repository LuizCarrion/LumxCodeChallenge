//
//  MovieDetailsRequest.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 14/03/24.
//

import Foundation

struct MovieDetailsRequest: DataRequest {
  typealias Response = MovieDetails

  static var baseUrl: String {
    return "https://api.themoviedb.org/3/movie/"
  }

  var url: String

  var method: HTTPMethod {
    .get
  }

  var headers: [String : String] {
    return ["Authorization" : "Bearer " + ApiKey.key]
  }

  init(path: String) {
    self.url = MovieDetailsRequest.baseUrl + path
  }

  func decode(_ data: Data) throws -> MovieDetails {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-mm-dd"
    decoder.dateDecodingStrategy = .formatted(dateFormatter)

    let response = try decoder.decode(MovieDetails.self, from: data)
    return response
  }
}


struct CastDetailsRequest: DataRequest {
  typealias Response = CreditsResponse

  static var baseUrl: String {
    return "https://api.themoviedb.org/3/movie/"
  }

  var url: String

  var method: HTTPMethod {
    .get
  }

  var headers: [String : String] {
    return ["Authorization" : "Bearer " + ApiKey.key]
  }

  init(path: String) {
    self.url = MovieDetailsRequest.baseUrl + path + "/credits"
  }

  func decode(_ data: Data) throws -> CreditsResponse {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-mm-dd"
    decoder.dateDecodingStrategy = .formatted(dateFormatter)

    let response = try decoder.decode(CreditsResponse.self, from: data)
    return response
  }
}
