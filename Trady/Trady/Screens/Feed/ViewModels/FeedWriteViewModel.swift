//
//  FeedWriteViewModel.swift
//  Trady
//
//  Created by USER on 2021/07/19.
//

import Foundation
import SwiftUI

class FeedWriteViewModel: EventHandler {
    
    @Published private(set) var isPresented = false
    weak var parent: EventHandler?
    var children: [EventHandler] = []
    
    init() {
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
            default:
                break
            }
        } else {
            debugPrint("wrong Event passed \(event)")
            return
        }
    }
    
}
