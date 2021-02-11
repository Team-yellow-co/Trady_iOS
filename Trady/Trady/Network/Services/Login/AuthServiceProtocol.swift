//
//  AuthServiceProtocol.swift
//  Trady
//
//  Created by bumslap on 2021/02/07.
//

import Foundation
import FirebaseAuth
import Combine
import CryptoKit

protocol AuthServiceProtocol {
    func fetchUid() -> String?
    func signIn(with email: String, password: String) -> AnyPublisher<(), Error>
    func signIn(with credential: AuthCredential) -> AnyPublisher<(), Error>
    func signUp(with email: String,
                password: String) -> AnyPublisher<(), Error>
    func logOut() -> AnyPublisher<(), Error>
}

extension AuthServiceProtocol {
    
    func makeNonce() -> String {
        let nonce = sha256(randomNonceString())
        return nonce
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }

    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hashFunction.digest(inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()

        return hashString
    }

}
