//
//  GoogleSignInProxy.swift
//  Trady
//
//  Created by bumslap on 2021/02/06.
//

import Foundation
import GoogleSignIn
import Combine

class GoogleSignInProxy: NSObject, GIDSignInDelegate {

    deinit {
        signInUserSubject.send(completion: .finished)
    }

    private let signInUserSubject: PassthroughSubject<GIDGoogleUser, Error> = .init()
    
    var signIn: AnyPublisher<GIDGoogleUser, Error> {
        return signInUserSubject.eraseToAnyPublisher()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            signInUserSubject.send(completion: .failure(error))
        } else {
            signInUserSubject.send(user)
        }
    }
    
    
}

extension GIDSignIn {
    
    func combine(proxy: GoogleSignInProxy) -> GoogleSignInProxy {
        self.delegate = proxy
        return proxy
    }
}

