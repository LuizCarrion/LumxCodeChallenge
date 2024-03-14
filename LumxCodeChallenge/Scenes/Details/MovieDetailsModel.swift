//
//  MovieDetailsModel.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 14/03/24.
//

import Foundation

struct MovieDetails: Decodable {
  let adult: Bool?
  let backdropPath: String?
  let belongsToCollection: Collection?
  let budget: Int?
  let genres: [Genre]?
  let homepage: String?
  let id: Int?
  let imdbId: String?
  let originalLanguage: String?
  let originalTitle: String?
  let overview: String?
  let popularity: Double?
  let posterPath: String?
  let productionCompanies: [ProductionCompany]?
  let productionCountries: [ProductionCountry]?
  let releaseDate: String?
  let revenue: Int?
  let runtime: Int?
  let spokenLanguages: [SpokenLanguage]?
  let status: String?
  let tagline: String?
  let title: String?
  let video: Bool?
  let voteAverage: Double?
  let voteCount: Int
}

struct Collection: Codable {
  let id: Int?
  let name: String?
  let posterPath: String?
  let backdropPath: String?
}

struct Genre: Codable {
  let id: Int?
  let name: String?
}

struct ProductionCompany: Codable {
  let id: Int?
  let logoPath: String?
  let name: String?
  let originCountry: String?
}

struct ProductionCountry: Codable {
  let iso3166_1: String?
  let name: String?
}

struct SpokenLanguage: Codable {
  let englishName: String?
  let iso639_1: String?
  let name: String?
}
