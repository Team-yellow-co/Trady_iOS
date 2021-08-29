//
//  FeedServiceProtocol.swift
//  Trady
//
//  Created by USER on 2021/08/29.
//

import Foundation

protocol FeedServiceProtocol {
    func getFeeds(numberOfItemsPerPage: Int,
                  pagingKey: String?,
                  locationTag: Int?) -> [Post]
}
