//
//  AppPhaseManager.swift
//  Trady
//
//  Created by USER on 2021/03/02.
//

import Foundation

protocol AppPhaseManagerProtocol {
    var currentPhase: AppPhaseManager.Phase { get }
}

class AppPhaseManager: AppPhaseManagerProtocol {
    
    enum Phase {
        case dev
        case real
    }
    
    static let shared: AppPhaseManager = AppPhaseManager()
    
    var currentPhase: Phase {
        #if DEBUG
            return .dev
        #else
            return .real
        #endif
    }
    
    private init() {}
    

}
