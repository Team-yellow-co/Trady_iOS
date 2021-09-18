//
//  FeedTagSelectionViewModel.swift
//  Trady
//
//  Created by USER on 2021/09/19.
//

import Foundation
import SwiftUI
import Combine

class FeedTagSelectionViewModel: EventHandler, ObservableObject {
    
    @Published private(set) var isPresented = false
    private var subscriptions = Set<AnyCancellable>()
    weak var parent: EventHandler?
    var children: [EventHandler] = []
    var locationTags: [MasterLocationTag] = []
    
    private let locationService: LocationServiceProtocol
    
    init(locationService: LocationServiceProtocol = LocationService()) {
        self.locationService = locationService
        
        self.locationService.getLocationList()
            .sink { comp in
                switch comp {
                case .failure(let error):
                    print(error)
                default:
                    break
                }
            } receiveValue: { [weak self] tags in
                self?.locationTags = tags
            }
            .store(in: &subscriptions)

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
            
            default:
                break
            }
        } else {
            debugPrint("wrong Event passed \(event)")
            return
        }
    }
}

