//
//  MoviesModel.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 11/03/24.
//

import Foundation

typealias Movies = [Movie]

struct MovieResponse: Decodable {
  let dates: DateRange
  let page: Int
  let results: Movies
  let totalPages: Int
  let totalResults: Int
}

// MARK: - Date range for movie listings
struct DateRange: Decodable {
  let maximum: String
  let minimum: String
}

// MARK: - Movie details
struct Movie: Decodable {
  let adult: Bool
  let backdropPath: String?
  let genreIds: [Int]
  let id: Int
  let originalLanguage: String
  let originalTitle: String
  let overview: String
  let popularity: Double
  let posterPath: String?
  let releaseDate: String
  let title: String
  let video: Bool
  let voteAverage: Double
  let voteCount: Int
}
