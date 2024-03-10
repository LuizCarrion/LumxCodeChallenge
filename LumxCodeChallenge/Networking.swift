//
//  Networking.swift
//  LumxCodeChallenge
//
//  Created by Luiz Carrion on 08/03/24.
//

import Foundation

struct ApiKey {
  static let key = ""
}

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"
}

protocol DataRequest {
  associatedtype Response

  var url: String { get }
  var method: HTTPMethod { get }
  var headers: [String : String] { get }
  var queryItems: [String : String] { get }

  func decode(_ data: Data) throws -> Response
}

extension DataRequest where Response: Decodable {
  func decode(_ data: Data) throws -> Response {
    let decoder = JSONDecoder()
    return try decoder.decode(Response.self, from: data)
  }
}

extension DataRequest {
  var headers: [String : String] {
    [:]
  }

  var queryItems: [String : String] {
    [:]
  }
}

enum ErrorResponse: String {
  case apiError
  case invalidEndpoint
  case invalidResponse
  case noData
  case serializationError

  public var description: String {
    switch self {
      case .apiError: return "Ooops, there is something problem with the api"
      case .invalidEndpoint: return "Ooops, there is something problem with the endpoint"
      case .invalidResponse: return "Ooops, there is something problem with the response"
      case .noData: return "Ooops, there is something problem with the data"
      case .serializationError: return "Ooops, there is something problem with the serialization process"
    }
  }
}

protocol NetworkService {
  func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void)
}

final class DefaultNetworkService: NetworkService {

  func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void) {

    guard var urlComponent = URLComponents(string: request.url) else {
      let error = NSError(
        domain: ErrorResponse.invalidEndpoint.rawValue,
        code: 404,
        userInfo: nil
      )

      return completion(.failure(error))
    }

    var queryItems: [URLQueryItem] = []

    request.queryItems.forEach {
      let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
      urlComponent.queryItems?.append(urlQueryItem)
      queryItems.append(urlQueryItem)
    }

    urlComponent.queryItems = queryItems

    guard let url = urlComponent.url else {
      let error = NSError(
        domain: ErrorResponse.invalidEndpoint.rawValue,
        code: 404,
        userInfo: nil
      )

      return completion(.failure(error))
    }

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = request.method.rawValue
    urlRequest.allHTTPHeaderFields = request.headers

    URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      if let error = error {
        return completion(.failure(error))
      }

      guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
        return completion(.failure(NSError()))
      }

      guard let data = data else {
        return completion(.failure(NSError()))
      }

      do {
        try completion(.success(request.decode(data)))
      } catch let error as NSError {
        completion(.failure(error))
      }
    }
    .resume()
  }
}
