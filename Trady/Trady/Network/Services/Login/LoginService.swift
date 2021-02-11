//
//  LoginService.swift
//  Trady
//
//  Created by bumslap on 2021/01/29.
//

import Foundation
import Combine
import GoogleSignIn
import AuthenticationServices
import FirebaseAuth


struct LoginService: LoginServiceProtocol {
    let authService: AuthServiceProtocol = Auth.auth()
    let googleSignInProxy = GoogleSignInProxy()
    let appleSignInProxy = AppleSignInProxy()
    func login(with form: LoginForm) -> AnyPublisher<(), Error> {
        let type = form.type
        switch type {
        case .apple:
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            let currentNonce = authService.makeNonce()
            request.requestedScopes = [.fullName, .email]
            request.nonce = currentNonce
            let authController = ASAuthorizationController(authorizationRequests: [request])
            authController.performRequests()
            return authController.combine(proxy: appleSignInProxy).signIn
                .flatMap { user -> AnyPublisher<(), Error> in
                    if let appleIDCredential = user.credential as? ASAuthorizationAppleIDCredential {
                        guard let appleIDToken = appleIDCredential.identityToken else {
                            return Fail(error: APIError.notDefined).eraseToAnyPublisher()
                        }
                        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                            return Fail(error: APIError.notDefined).eraseToAnyPublisher()
                        }
                        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com",
                                                                          idToken: idTokenString,
                                                                          rawNonce: currentNonce)
                        return self.authService.signIn(with: firebaseCredential)
                    } else {
                        return Fail(error: APIError.notDefined).eraseToAnyPublisher()
                    }
                }.eraseToAnyPublisher()
            //https://www.raywenderlich.com/4875322-sign-in-with-apple-using-swiftui
        case .google:
            if let googleSignInInstance = GIDSignIn.sharedInstance() {
                googleSignInInstance.presentingViewController = UIApplication.shared.windows.last?.rootViewController
                googleSignInInstance.signIn()
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

