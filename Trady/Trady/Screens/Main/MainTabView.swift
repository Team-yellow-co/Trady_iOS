//
//  MainTabView.swift
//  Trady
//
//  Created by bumslap on 2021/01/24.
//

import SwiftUI

struct MainTabView: View {
    init() {
        UITabBar.appearance().barTintColor = UIColor.white
    }
    var body: some View {
        TabView {
            FeedView()
                .tabItem { Image("tab_home") }
            ChatView()
                .tabItem { Image("tab_chat") }
            AlarmView()
                .tabItem { Image("tab_alarm") }
            MyView()
                .tabItem { Image("tab_my") }
        }
        .accentColor(.red)
        
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
