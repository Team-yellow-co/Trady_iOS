//
//  FeedViewModel.swift
//  Trady
//
//  Created by USER on 2021/07/16.
//

import Foundation
import Combine

class FeedViewModel: EventHandler {
    
    private let feedService = FeedService(network: FireStoreServer())
    @Published var feedCellViewModels: [FeedCellViewModel] = []
    private(set) var feedWriteViewModel: FeedWriteViewModel = FeedWriteViewModel()
    weak var parent: EventHandler?
    var children: [EventHandler] = []
    
    @Published private(set) var isFeedWriteViewShowing = false
    
    init() {
        (0...10).forEach { _ in
            feedCellViewModels.append(FeedCellViewModel())
        }
        add(child: feedWriteViewModel)
    }
    
    func receive(event: Event) {
        if let feedEvent = event as? FeedEvent {
            defer {
                passDown(event: event)
            }
            switch feedEvent {
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
