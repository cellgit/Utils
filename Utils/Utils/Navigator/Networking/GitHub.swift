//
//  GitHub.swift
//  Utils
//
//  Created by liuhongli on 2021/3/1.
//

import Foundation

enum GitHub {
  static func repos(username: String, completion: @escaping (Result<[Repo]>) -> Void) {
    HTTP.request("/users/\(username)/repos?sort=updated") { result in
      result
        .map { data -> [Repo] in
          let repos = try? JSONDecoder().decode([Repo].self, from: data)
          return repos ?? []
        }
        .apply(completion)
    }
  }
}

