//
//  FeedWriteViewModel.swift
//  Trady
//
//  Created by USER on 2021/07/19.
//

import Foundation
import SwiftUI
import Combine

class FeedWriteViewModel: EventHandler {
    
    @Published private(set) var isPresented = false
    private var subscriptions = Set<AnyCancellable>()
    weak var parent: EventHandler?
    var children: [EventHandler] = []
    
    private let feedService: FeedServiceProtocol
    
    init(feedService: FeedServiceProtocol = FeedService(network: FireStoreServer())) {
        self.feedService = feedService
    }
    
    deinit {
        removeFromParent()
    }
    
    func receive(event: Event) {
        if let feedEvent = event as? FeedEvent {
            defer {
                passDown(event: event)
            }
            switch feedEvent {
            case .writeButtonTouched:
                isPresented = true
            case .writeCompleted(let title,
                                 let content,
                                 let tags):
                let today = Date()
                let post = Post(title: title,
                                id: nil,
                                content: content,
                                profileImageUrl: nil,
                                likeCount: nil,
                                viewCount: nil,
                                createdAt: today,
                                tags: tags)
                feedService.writePost(with: post)
                    .sink { comp in
                        switch comp {
                        case .failure(let error):
                            print(error)
                        case .finished:
                            break
                        }
                    } receiveValue: { data in
                        print(data)
                    }
                    .store(in: &subscriptions)
            default:
                break
            }
        } else {
            debugPrint("wrong Event passed \(event)")
            return
        }
    }
    
}
