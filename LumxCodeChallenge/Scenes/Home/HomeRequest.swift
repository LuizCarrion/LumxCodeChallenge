//
//  HomeRequest.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 11/03/24.
//

import Foundation

struct HomeRequest: DataRequest {
  typealias Response = MovieResponse

  var url: String {
    return "https://api.themoviedb.org/3/movie/upcoming"
  }

  var method: HTTPMethod {
    .get
  }

  var headers: [String : String] {
    return ["Authorization" : "Bearer " + ApiKey.key]
  }

  func decode(_ data: Data) throws -> MovieResponse {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-mm-dd"
    decoder.dateDecodingStrategy = .formatted(dateFormatter)

    let response = try decoder.decode(MovieResponse.self, from: data)
    return response
  }
}
