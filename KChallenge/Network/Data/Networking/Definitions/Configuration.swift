//
//  Configuration.swift
//  KChallenge
//
//  Created by Carlos Guerra Lopez on 18/08/24.
//

import Foundation

protocol HttpConfiguration {
  var headers: [String: String] { get }
  var requestTimeoutInterval: TimeInterval { get }
}

extension HttpConfiguration {
  var requestTimeoutInterval: TimeInterval {
    return 10.0
  }
}

struct SettingsHttpConfiguration: HttpConfiguration {
  var headers: [String: String] {
    var headers: [String: String] = [:]

    headers["Api-Version"] = "\(API.version.rawValue)"
    headers["App-Name"] = AppInfo.appName
    headers["Platform"] = AppInfo.osName
    headers["App-Version"] = AppInfo.shortVersion
    headers["Content-Type"] = "application/json"
    headers["Accept"] = "application/json"
    return headers
  }
}
