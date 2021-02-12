//
//  CancelBag.swift
//  Trady
//
//  Created by bumslap on 2021/02/13.
//

import Foundation
import Combine

class SubscriptionBag {
    var subscriptions = Set<AnyCancellable>()
    
    func cancel() {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
}

extension AnyCancellable {
    func store(in cancelBag: SubscriptionBag) {
        cancelBag.subscriptions.insert(self)
    }
}
