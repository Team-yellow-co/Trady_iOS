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
    let authService: AuthServiceProtocol = Auth.auth()
    let googleSignInProxy = GoogleSignInProxy()
    func login(with form: LoginForm) -> AnyPublisher<(), Error> {
        let type = form.type
        switch type {
        case .apple:
            return Just(())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
            //https://www.raywenderlich.com/4875322-sign-in-with-apple-using-swiftui
        case .google:
            if let googleSignInInstance = GIDSignIn.sharedInstance() {
                return googleSignInInstance.combine(proxy: googleSignInProxy).signIn
                    .flatMap { user -> AnyPublisher<(), Error> in
                        if let authentification = user.authentication {
                            let googleAuthInfo = GoogleAuthProvider.credential(withIDToken: authentification.idToken,
                                                                               accessToken: authentification.accessToken)
                            return authService.signIn(with: googleAuthInfo)
                        } else {
                            return Fail(error: APIError.notDefined)
                                .eraseToAnyPublisher()
                        }
                    }.eraseToAnyPublisher()
            } else {
                return Fail(error: APIError.notDefined).eraseToAnyPublisher()
            }
            
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
            return Fail(error: APIError.notDefined)
                .eraseToAnyPublisher()
        }
    }
}

