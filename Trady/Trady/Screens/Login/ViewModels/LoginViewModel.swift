//
//  LoginViewModel.swift
//  Trady
//
//  Created by bumslap on 2021/01/28.
//

import Foundation
import Combine

struct LoginViewModel: ViewModelType {
    
    final class Input: ObservableObject {
        let loginTrigger: AnyPublisher<LoginForm, Never>
        
        init(loginTrigger: AnyPublisher<LoginForm, Never>) {
            self.loginTrigger = loginTrigger
        }
    }
    
    final class Output: ObservableObject {
        @Published var isLoginInProcess: Bool = false
        @Published var showLoginFailAlert: Bool = false
        
        init() {
            
        }
    }
    
    private let loginService: LoginServiceProtocol = LoginService()
    private let setting: AppSetting
    
    init(setting: AppSetting) {
        self.setting = setting
    }
    
    func transform(input: Input,
                   subscriptions: SubscriptionBag) -> Output {
        let output = Output()
        input.loginTrigger
            .print("login")
            .filter { _ in output.isLoginInProcess == false }
            .handleEvents(receiveOutput: { _ in
                output.isLoginInProcess = true
            })
            .flatMap { form -> AnyPublisher<(), Error> in
                return self.loginService.login(with: form)
            }
            .sink { (completion) in
                output.isLoginInProcess = false
                switch completion {
                case .failure(let error):
                    output.showLoginFailAlert = true
                case .finished:
                    break
                }
            } receiveValue: { _ in
                output.isLoginInProcess = false
                self.setting.isAuthorized = true
            }
            .store(in: subscriptions)
        
        return output
    }

}
