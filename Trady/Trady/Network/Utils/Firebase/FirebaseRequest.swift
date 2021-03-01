//
//  FirebaseRequest.swift
//  Trady
//
//  Created by USER on 2021/03/01.
//

import Foundation

struct FirebaseRequest: URLRequestProtocol {
    var path: String
    var kind: RequestKind
    var queries: [(kind: Query, value: Any)]?
    var body: [AnyHashable : Any]?
    
    init(path: String,
         kind: RequestKind,
         queries: [(Query, Any)]?,
         body: [AnyHashable : Any]?) {
        self.path = path
        self.kind = kind
        self.body = body
        self.queries = queries
    }
}
