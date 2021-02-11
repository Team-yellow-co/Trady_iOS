//
//  EnteringView.swift
//  Trady
//
//  Created by bumslap on 2021/01/27.
//

import SwiftUI

struct EnteringView: View {
    
    @EnvironmentObject var appSetting: AppSetting
    init() {
        print("")
    }
    var body: some View {
        if appSetting.isAuthorized {
            return AnyView(MainTabView())
        } else {
            let loginViewModel = LoginViewModel(setting: appSetting)
            return AnyView(LoginContentView(viewModel: loginViewModel))
        }
    }
}

struct EnteringView_Previews: PreviewProvider {
    static var previews: some View {
        EnteringView()
    }
}
