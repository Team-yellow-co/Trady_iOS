//
//  FeedViewModel.swift
//  Trady
//
//  Created by USER on 2021/07/16.
//

import Foundation
import Combine

class FeedViewModel: EventHandler, ObservableObject {
    
    private let feedService = FeedService(network: FireStoreServer())
    @Published var feedCellViewModels: [FeedCellViewModel] = []
    @Published var isFeedWriteShowing = false
    private var currentPagingKey: String?
    private(set) var feedWriteViewModel: FeedWriteViewModel = FeedWriteViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    weak var parent: EventHandler?
    var children: [EventHandler] = []
    
    @Published private(set) var isFeedWriteViewShowing = false
    
    init() {
        feedService.getFeeds(numberOfItemsPerPage: 20,
                             pagingKey: nil,
                             locationTag: nil)
            .sink { comp in
                switch comp {
                case .failure(let error):
                    print(error)
                default:
                    break
                }
            } receiveValue: { posts in
                self.feedCellViewModels = posts.map { FeedCellViewModel(post: $0) }
                
            }
            .store(in: &subscriptions)
        add(child: feedWriteViewModel)
    }
    
    func receive(event: Event) {
        if let feedEvent = event as? FeedEvent {
            defer {
                passDown(event: event)
            }
            switch feedEvent {
            case .showFeedWriteView:
                isFeedWriteShowing = true
            case .hideFeedWriteView(let isPostWriteAction):
                isFeedWriteShowing = false
                currentPagingKey = nil
                if isPostWriteAction {
                    feedService.getFeeds(numberOfItemsPerPage: 20,
                                         pagingKey: currentPagingKey,
                                         locationTag: nil)
                        .sink { comp in
                            switch comp {
                            case .failure(let error):
                                print(error)
                            default:
                                break
                            }
                        } receiveValue: { posts in
                            self.feedCellViewModels = posts.map { FeedCellViewModel(post: $0) }
                            
                        }
                        .store(in: &subscriptions)
                }
            case .writeButtonTouched:
                break
            case .onAppear:
                break
            default:
                break
            }
        } else {
            debugPrint("wrong Event passed \(event)")
            return
        }
    }
}
