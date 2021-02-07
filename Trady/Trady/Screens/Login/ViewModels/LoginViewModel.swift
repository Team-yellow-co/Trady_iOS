//
//  LoginViewModel.swift
//  Trady
//
//  Created by bumslap on 2021/01/28.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    private var subscriptions = Set<AnyCancellable>()
    let loginService: LoginServiceProtocol = LoginService()
    let setting: AppSetting
    
    init(setting: AppSetting) {
        self.setting = setting
    }
    
    
    deinit {
        print("LoginViewModel deinit")
    }
    func login(with type: LoginType) {
        let form = LoginForm(type: type, email: nil, password: nil)
        loginService.login(with: form)
            .print("login: ")
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    break
                case .finished:
                    break
                }
            } receiveValue: { [weak self] _ in
                self?.setting.isAuthorized = true
            }
            .store(in: &subscriptions)

    }
}
