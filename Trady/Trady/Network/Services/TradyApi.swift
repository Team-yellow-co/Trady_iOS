//
//  TradyApi.swift
//  Trady
//
//  Created by USER on 2021/08/29.
//

import Foundation

enum TradyApi {
    case getFeeds(numberOfItemsPerPage: Int,
                  pagingKey: String?,
                  locationTag: Int?)
    
    case writePost(post: Post)
    
    var path: String {
        switch self {
        case .getFeeds:
            return "feed/posts"
        case .writePost:
            return "feed/posts"
        }
    }
    
    var parameters: [(Query, Any)] {
        switch self {
        case .getFeeds(let pageLimit, let pagingKey, let tag):
            if let tag = tag {
                if let key = pagingKey {
                    return [(Query.whereField(.array("tags")), tag),
                            (Query.startAt, key),
                            (Query.orderBy(.key, isDescending: true), "createdAt"),
                            (Query.limitToLast, pageLimit)]
                } else {
                    return [(Query.whereField(.array("tags")), tag),
                            (Query.orderBy(.key, isDescending: true), "createdAt"),
                            (Query.limitToLast, pageLimit)]
                }
            } else {
                if let key = pagingKey {
                    return [(Query.startAt, key),
                            (Query.orderBy(.key, isDescending: true), "createdAt"),
                            (Query.limitToLast, pageLimit)]
                } else {
                    return [(Query.orderBy(.key, isDescending: true), "createdAt"),
                            (Query.limitToLast, pageLimit)]
                }
            }
        case .writePost(let post):
            return []
        }
    }
}
