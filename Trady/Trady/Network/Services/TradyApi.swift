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
    
    var path: String {
        switch self {
        case .getFeeds:
            return "feed/posts"
        }
    }
    
    var parameters: [(Query, Any)]{
        switch self {
        case .getFeeds(let pageLimit, let pagingKey, let tag):
            if let tag = tag {
                if let key = pagingKey {
                    return [(Query.whereField(.array("tags")), tag),
                            (Query.startAt, key),
                            (Query.limitToLast, pageLimit)]
                } else {
                    return [(Query.whereField(.array("tags")), tag),
                            (Query.limitToLast, pageLimit)]
                }
            } else {
                if let key = pagingKey {
                    return [(Query.startAt, key),
                            (Query.limitToLast, pageLimit)]
                } else {
                    return [(Query.limitToLast, pageLimit)]
                }
            }
        }
    }
}
