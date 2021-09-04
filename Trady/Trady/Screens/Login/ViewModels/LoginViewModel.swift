//
//  LoginViewModel.swift
//  Trady
//
//  Created by bumslap on 2021/01/28.
//

import Foundation
import Combine

class LoginViewModel: ViewModelType {
    let isTestMode = true
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
    private var subscriptions = Set<AnyCancellable>()
    
    init(setting: AppSetting) {
        self.setting = setting
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        input.loginTrigger
            .print("login")
            .filter { _ in output.isLoginInProcess == false }
            .handleEvents(receiveOutput: { _ in
                output.isLoginInProcess = true
            })
            .flatMap { form -> AnyPublisher<Result<(), Error>, Never> in
                return self.loginService.login(with: form)
                    .map { return Result<(), Error>.success(())}
                    .catch { [weak self] error -> AnyPublisher<Result<(), Error>, Never> in
                        if self?.isTestMode ?? false {
                            return Just(Result.success(())).eraseToAnyPublisher()
                        } else {
                            return Just(Result.failure(error)).eraseToAnyPublisher()
                        }
                    }
                    .eraseToAnyPublisher()
            }
            .sink { (completion) in
            } receiveValue: { [weak self] result in
                output.isLoginInProcess = false
                switch result {
                case .failure(let error):
                    output.showLoginFailAlert = true
                case .success:
                    self?.setting.isAuthorized = true
                }
            }
            .store(in: &subscriptions)
        
        return output
    }

}
