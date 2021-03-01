//
//  Network.swift
//  Trady
//
//  Created by USER on 2021/03/01.
//

import Foundation
import Combine

protocol Network {
    func dispatch(request: URLRequestProtocol, completion: @escaping (Result<Data?, Error>) -> Void)
    func dispatch(request: URLRequestProtocol) -> AnyPublisher<Data?, Error>
}
