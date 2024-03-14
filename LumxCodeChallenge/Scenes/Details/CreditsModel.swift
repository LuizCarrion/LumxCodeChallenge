//
//  CreditsModel.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 14/03/24.
//

struct CreditsResponse: Codable {
  let id: Int
  let cast: [CastMember]
  let crew: [CrewMember]
}

struct CastMember: Codable {
  let adult: Bool?
  let gender: Int?
  let id: Int?
  let knownForDepartment: String?
  let name: String?
  let originalName: String?
  let popularity: Double?
  let profilePath: String?
  let castId: Int?
  let character: String?
  let creditId: String?
  let order: Int?
}

struct CrewMember: Codable {
  let adult: Bool?
  let gender: Int?
  let id: Int?
  let knownForDepartment: String?
  let name: String?
  let originalName: String?
  let popularity: Double?
  let profilePath: String?
  let creditId: String?
  let department: String?
  let job: String?
}
