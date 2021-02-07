//
//  AuthService.swift
//  Trady
//
//  Created by bumslap on 2021/02/07.
//

import Foundation
import FirebaseAuth
import Combine

extension Auth: AuthServiceProtocol {
    
    func logOut() -> AnyPublisher<(), Error> {
        do {
            try self.signOut()
            return Just(())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: APIError.requestFailed)
                .eraseToAnyPublisher()
        }
    }
    
    func fetchUid() -> String? {
        return self.currentUser?.uid
    }
    
    func signIn(with email: String,
                password: String) -> AnyPublisher<(), Error> {
        let auth = Future<(), Error> { [weak self] promise in
            guard let self = self else {
                promise(.failure(APIError.notDefined))
                return
            }
            self.signIn(withEmail: email,
                        password: password) { (authResult, error) in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                if let uid = authResult?.user.uid {
                    //TODO: uid가 DB에 저장되어야할 수 있음
                    promise(.success(()))
                    return
                }
                promise(.failure(APIError.notDefined))
            }
        }
        .eraseToAnyPublisher()
        return auth
    }
    
    func signIn(with credential: AuthCredential) -> AnyPublisher<(), Error>  {
        let auth = Future<(), Error> { [weak self] promise in
            guard let self = self else {
                promise(.failure(APIError.notDefined))
                return
            }
            self.signIn(with: credential) { (authResult, error) in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                if let uid = authResult?.user.uid {
                    //TODO: uid가 DB에 저장되어야할 수 있음
                    promise(.success(()))
                    return
                }
                promise(.failure(APIError.notDefined))
            }
        }
        .eraseToAnyPublisher()
        return auth
    }
    
    func signUp(with email: String,
                password: String) -> AnyPublisher<(), Error> {
        let auth = Future<(), Error> { [weak self] promise in
            guard let self = self else {
                promise(.failure(APIError.notDefined))
                return
            }
            self.createUser(withEmail: email, password: password) { (authResult, error) in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                if let uid = authResult?.user.uid {
                    promise(.success(()))
                    return
                }
                promise(.failure(APIError.notDefined))
            }
        }
        .eraseToAnyPublisher()
        return auth
    }
}
