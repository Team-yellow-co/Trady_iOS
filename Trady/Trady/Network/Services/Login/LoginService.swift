//
//  LoginService.swift
//  Trady
//
//  Created by bumslap on 2021/01/29.
//

import Foundation
import Combine
import GoogleSignIn
import FirebaseAuth


struct LoginService: LoginServiceProtocol {
    func login(with form: LoginForm) -> AnyPublisher<Void, Error> {
        let type = form.type
        switch type {
        case .apple:
            return Just(())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
            //https://www.raywenderlich.com/4875322-sign-in-with-apple-using-swiftui
        case .google:
            GIDSignIn.sharedInstance()?.signIn()
            return Just(())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        case .email:
            if let email = form.email, let password = form.password {
                return Future<Void, Error> { promise in
                    Auth.auth().signIn(withEmail: email,
                                       password: password) { (result, error) in
                        if let error = error {
                            return promise(.failure(error))
                        }
                        return promise(.success(()))
                    }
                }
                .eraseToAnyPublisher()
            } else {
                fallthrough
            }
        default:
            return Fail(error: NSError(domain: "", code: -1, userInfo: nil))
                .eraseToAnyPublisher()
        }
    }
}
