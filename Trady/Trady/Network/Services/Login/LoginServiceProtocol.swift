//
//  LoginServiceProtocol.swift
//  Trady
//
//  Created by bumslap on 2021/01/29.
//

import Foundation
import Combine

protocol LoginServiceProtocol {
    func login(with form: LoginForm) -> AnyPublisher<Void, Error>
}
