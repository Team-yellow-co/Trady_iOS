//
//  FeedService.swift
//  Trady
//
//  Created by USER on 2021/08/29.
//

import Foundation
import Combine

class FeedService: FeedServiceProtocol {
    private let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    func getFeeds(numberOfItemsPerPage: Int,
                  pagingKey: String?,
                  locationTag: Int?) -> AnyPublisher<[Post], Error> {
        let api = TradyApi.getFeeds(numberOfItemsPerPage: numberOfItemsPerPage,
                                    pagingKey: pagingKey,
                                    locationTag: locationTag)
        
        let request = FirebaseRequest(path: api.path,
                                      kind: .observeSingleEvent,
                                      queries: api.parameters,
                                      body: nil)
        return network.dispatch(request: request)
            .compactMap { $0 }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func writePost(with post: Post) -> AnyPublisher<Data?, Error> {
        let api = TradyApi.writePost(post: post)
        
        let request = FirebaseRequest(path: api.path,
                                      kind: .set,
                                      queries: api.parameters,
                                      body: post.dictionary)
        return network.dispatch(request: request)
            .eraseToAnyPublisher()
    }
}
