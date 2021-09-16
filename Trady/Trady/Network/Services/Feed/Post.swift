//
//  Post.swift
//  Trady
//
//  Created by USER on 2021/08/29.
//

import Foundation

struct Post: Codable {
    let title: String
    let id: Int?
    let content: String
    let profileImageUrl: String?
    let likeCount: Int?
    let viewCount: Int?
    let createdAt: Date
    let tags: [Int]
}

extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}
