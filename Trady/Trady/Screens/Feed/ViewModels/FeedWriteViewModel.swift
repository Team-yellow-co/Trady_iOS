//
//  FeedWriteViewModel.swift
//  Trady
//
//  Created by USER on 2021/07/19.
//

import Foundation
import SwiftUI
import Combine
import FirebaseAuth

class FeedWriteViewModel: EventHandler, ObservableObject {
    @Published var isTagSeletionViewShowing = false
    private(set) var feedTagSelectionViewModel: FeedTagSelectionViewModel = FeedTagSelectionViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var locationTags = Set<LocationTag>()
    weak var parent: EventHandler?
    var children: [EventHandler] = []
    
    private let feedService: FeedServiceProtocol
    private let authService: AuthServiceProtocol
    
    init(feedService: FeedServiceProtocol = FeedService(network: FireStoreServer()),
         authService: AuthServiceProtocol = Auth.auth()) {
        self.feedService = feedService
        self.authService = authService
        add(child: feedTagSelectionViewModel)
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
                break
                //isPresented = true
            case .writeCompleted(let title,
                                 let content):
                guard let id = authService.fetchUid() else {
                    return
                }
                let today = Date()
                let tags = locationTags.map { $0.locationCode }
                
                let post = Post(title: title,
                                id: id,
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
                    } receiveValue: { [weak self] data in
                        self?.send(event: FeedEvent.hideFeedWriteView(isPostWriteAction: true))
                    }
                    .store(in: &subscriptions)
            case .showTagSelectView:
                isTagSeletionViewShowing = true
            case .tagSelected(let tag):
                locationTags.update(with: tag)
                isTagSeletionViewShowing = false
            case .tagCompleted:
                isTagSeletionViewShowing = false
            default:
                break
            }
        } else {
            debugPrint("wrong Event passed \(event)")
            return
        }
    }
}
