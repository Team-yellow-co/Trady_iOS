//
//  EnteringView.swift
//  Trady
//
//  Created by bumslap on 2021/01/27.
//

import SwiftUI

struct EnteringView: View {
    
    @EnvironmentObject var appSetting: AppSetting
    
    var body: some View {
        if appSetting.isAuthorized {
            return AnyView(MainTabView())
        } else {
            return AnyView(LoginContentView())
        }
    }
}

struct EnteringView_Previews: PreviewProvider {
    static var previews: some View {
        EnteringView()
    }
}
