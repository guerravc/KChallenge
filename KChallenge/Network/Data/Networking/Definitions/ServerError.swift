//
//  ServerError.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation

enum ServerError: Error, LocalizedError {
  case network(issue: Issue)
  case objectSerialization(reason: String)
  case jsonSerialization(Error)
  case badUrl
  case unknown
  
  var title: String {
    return "An error has occurred!"
  }

  var message: String {
    switch self {
      case let .network(issue):
        switch issue {
        case .authorizationFailure:
          return "Your session has expired or you are no longer as valid user."
        case .maintenance:
          return "We are currently in maintenance. Please check back again later."
        case .internalServerError:
          return "System is currently misbehaving. Please check back again later."
        case .badRequest:
          return "The system just rejected us. Guess it didnt like what we sent. Please contact support"
        case .resourceNotFound:
          return "Resource not found"
        case let .custom(reason):
          return reason
        case let .server(error):
          return error.localizedDescription
        }
      case let .jsonSerialization(error):
        return error.localizedDescription
      case let .objectSerialization(reason):
        return reason
      case .badUrl:
        return "Unable to create URL"
      case .unknown:
        return "Unable to complete operation due to a bad internet connection."
      }
  }

  init(error: Error, status: HttpStatusCode) {
    self = .network(issue: .custom(error.localizedDescription))
  }

  init(status: HttpStatusCode = .badRequest){
    switch status.rawValue {
      case 400:
        self = .network(issue: .badRequest)
      case 401:
        self = .network(issue: .maintenance)
      case 403:
        self = .network(issue: .authorizationFailure)
      case 404:
        self = .network(issue: .resourceNotFound)
      default:
        self = .network(issue: .internalServerError)
    }
  }

  var status: HttpStatusCode {
    switch self {
    case let .network(issue):
      switch issue {
      case .badRequest:
        return .badRequest
      case .maintenance:
        return .unauthorized
      case .authorizationFailure:
        return .forbidden
      case .resourceNotFound:
        return .notFound
      case .custom:
        return .expectationFailed
      default:
        return .internalServerError
      }
    case .jsonSerialization, .objectSerialization:
      return .unprocessableEntity
    case .badUrl:
      return .notAcceptable
    case .unknown:
      return .clientClosedRequest
    }
  }

  var description:String {
    return "{message: \(String(describing: message)), status: \(String(describing: status))}"
  }

  var errorDescription: String? {
    return message
  }
}

public enum Issue {
  case authorizationFailure
  case maintenance
  case server(Error)
  case badRequest
  case internalServerError
  case resourceNotFound
  case custom(String)
}