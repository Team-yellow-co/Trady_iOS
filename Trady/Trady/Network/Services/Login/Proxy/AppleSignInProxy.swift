//
//  AppleSignInProxy.swift
//  Trady
//
//  Created by bumslap on 2021/02/12.
//

import Foundation
import AuthenticationServices
import Combine

class AppleSignInProxy: NSObject, ASAuthorizationControllerDelegate {

    deinit {
        signInUserSubject.send(completion: .finished)
    }

    private let signInUserSubject: PassthroughSubject<ASAuthorization, Error> = .init()
    
    var signIn: AnyPublisher<ASAuthorization, Error> {
        return signInUserSubject.eraseToAnyPublisher()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        signInUserSubject.send(completion: .failure(error))
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        signInUserSubject.send(authorization)
    }
    
}

extension ASAuthorizationController {
    
    func combine(proxy: AppleSignInProxy) -> AppleSignInProxy {
        self.delegate = proxy
        return proxy
    }
}

