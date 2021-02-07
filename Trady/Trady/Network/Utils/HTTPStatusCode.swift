//
//  HTTPStatusCode.swift
//  Trady
//
//  Created by bumslap on 2021/02/06.
//

import Foundation

public enum HTTPStatusCode: Int {
    case ok = 200
    case writeSuccess = 201
    
    case invalidRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
}
