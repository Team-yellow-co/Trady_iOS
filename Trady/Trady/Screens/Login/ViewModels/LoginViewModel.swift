//
//  LoginViewModel.swift
//  Trady
//
//  Created by bumslap on 2021/01/28.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    let setting: AppSetting
    
    init(setting: AppSetting) {
        self.setting = setting
    }
    
    func login(with type: LoginType) {
        
    }
}
