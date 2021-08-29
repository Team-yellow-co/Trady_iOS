//
//  URLRequestProtocol.swift
//  Trady
//
//  Created by bumslap on 2021/02/06.
//

import Foundation

protocol URLRequestProtocol {
    var path: String { get set }
    var kind: RequestKind { get set }
    var queries: [(kind: Query, value: Any)]? { get set }
    var body: [AnyHashable : Any]? { get set }
}

enum Query {
    case orderBy(OrderByType)
    case whereField(WhereFieldType)
    case equalTo
    case limitToLast
    case limitToFirst
    case startAt
    case endingAt
}

enum OrderByType {
    case child
    case key
}

enum WhereFieldType {
    case array(String)
    case element(String)
}

enum ObservingType {
    case added
    case changed
    case value
}

enum TransactionActionType {
    case increase
    case decrease
    case modify
}

enum RequestKind {
    case observe(ObservingType)
    case observeSingleEvent
    case set
    case setUnderAutoId
    case update
    case updateByTransaction(TransactionActionType)
    case remove
    case storageUpload(Data)
}

extension URLRequest: URLRequestProtocol {
    var path: String {
        get {
            return ""
        }
        set {
            
        }
    }
    
    var kind: RequestKind {
        get {
            return .observe(.value)
        }
        set {
            
        }
    }
    
    var queries: [(kind: Query, value: Any)]? {
        get {
            return nil
        }
        set {
            
        }
    }
    
    var body: [AnyHashable : Any]? {
        get {
            return nil
        }
        set {
            
        }
    }
    
    
}
