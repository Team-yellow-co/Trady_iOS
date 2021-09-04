//
//  Post.swift
//  Trady
//
//  Created by USER on 2021/08/29.
//

import Foundation

struct Post: Decodable {
    let title: String
    let id: Int
    let content: String
    let profileImageUrl: String?
    let likeCount: Int
    let viewCount: Int
    let createdAt: Date
    let tags: [Int]
}
