//
//  Repo.swift
//  Utils
//
//  Created by liuhongli on 2021/3/1.
//

struct Repo: Decodable {
  var name: String
  var descriptionText: String?
  var starCount: Int
  var urlString: String

  enum CodingKeys: String, CodingKey {
    case name = "name"
    case descriptionText = "description"
    case starCount = "stargazers_count"
    case urlString = "html_url"
  }
}
