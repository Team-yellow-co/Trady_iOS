//
//  EventHandler.swift
//  Trady
//
//  Created by USER on 2021/07/19.
//

import Foundation

protocol EventHandler: class {
    func receive(event: Event)
    var parent: EventHandler? { get set }
    var children: [EventHandler] { get set }
}

extension EventHandler {
    func send(event: Event) {
        if parent == nil {
            receive(event: event)
        } else {
            parent?.send(event: event)
        }
    }
    
    func passDown(event: Event) {
        children.forEach {
            $0.receive(event: event)
        }
    }
    
    func add(child: EventHandler) {
        children.append(child)
        child.parent = self
    }
    
    func removeFromParent() {
        parent?.children.removeAll { $0 === self }
    }
}

protocol Event {
    
}

protocol FeedEventType: Event {
    
}

enum FeedEvent: FeedEventType {
    case writeButtonTouched
}
