//
//  TradyApp.swift
//  Trady
//
//  Created by bumslap on 2021/01/23.
//

import SwiftUI

class AppSetting: ObservableObject {
   @Published var isAuthorized: Bool = false
}

@main
struct TradyApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject var appSetting = AppSetting()
    
    var body: some Scene {
        WindowGroup {
            EnteringView()
                .environmentObject(appSetting)
        }
        .onChange(of: scenePhase) { phase in
            
            if phase == .background {
                
            }
        }
    }
}

