//
//  FeedViewModel.swift
//  Trady
//
//  Created by USER on 2021/07/16.
//

import Foundation

class FeedViewModel {
    @Published var feedCellViewModels: [FeedCellViewModel] = []
    
    init() {
        feedCellViewModels = Array(repeating: FeedCellViewModel(), count: 10)
    }
}
