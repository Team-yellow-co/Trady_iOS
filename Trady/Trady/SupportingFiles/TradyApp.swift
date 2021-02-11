//
//  TradyApp.swift
//  Trady
//
//  Created by bumslap on 2021/01/23.
//

import SwiftUI
import Firebase
import GoogleSignIn

class AppSetting: ObservableObject {
   @Published var isAuthorized: Bool = false
}

@main
struct TradyApp: App {
    
    init() { 
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = "689501957472-okhc147jkv8b9ce9mbl8hjhn695uusa0.apps.googleusercontent.com"
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase
    
    @StateObject var appSetting = AppSetting()
    
    var body: some Scene {
        WindowGroup {
            EnteringView()
                .environmentObject(appSetting)
                .onOpenURL(perform: { url in
                    GIDSignIn.sharedInstance().handle(url)
                })
        }
        .onChange(of: scenePhase) { phase in
            
            if phase == .background {
                
            }
        }
    }
}

