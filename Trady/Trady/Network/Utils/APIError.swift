//
//  APIError.swift
//  Trady
//
//  Created by bumslap on 2021/02/07.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case urlFailure
    case notDefined
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .urlFailure: return "url Failure, app is gonna be off"
        case .notDefined: return "not defined"
        }
    }
}
