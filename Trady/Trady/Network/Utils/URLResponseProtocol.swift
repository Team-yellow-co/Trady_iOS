//
//  URLResponseProtocol.swift
//  Trady
//
//  Created by bumslap on 2021/02/06.
//

import Foundation

protocol URLResponseProtocol {
    var httpStatusCode: HTTPStatusCode { get }
    var url: URL? { get }
}

extension URLResponse: URLResponseProtocol {
    var httpStatusCode: HTTPStatusCode {
        let response = self as! HTTPURLResponse

        switch response.statusCode {
        case 200:
            return .ok
        case 201:
            return .writeSuccess
        case 400:
            return .invalidRequest
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 404:
            return .notFound
        default:
            return .invalidRequest
        }
    }
}
