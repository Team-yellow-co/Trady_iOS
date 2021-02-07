//
//  URLSessionTaskProtocol.swift
//  Trady
//
//  Created by bumslap on 2021/02/06.
//

import Foundation

protocol URLSessionTaskProtocol {
    var state: URLSessionTask.State { get }
    
    func resume()
    func cancel()
}
