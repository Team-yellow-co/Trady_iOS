//
//  URLSessionProtocol.swift
//  Trady
//
//  Created by bumslap on 2021/02/06.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with request: URLRequestProtocol, completionHandler: @escaping (Data?, URLResponseProtocol?, Error?) -> Void) -> URLSessionTaskProtocol
    
    
    func dataTask(with url: URL,
                  completionHandler: @escaping (Data?, URLResponseProtocol?, Error?) -> Void)
        -> URLSessionTaskProtocol
}

extension URLSession: URLSessionProtocol {
    
    func dataTask(with request: URLRequestProtocol, completionHandler: @escaping (Data?, URLResponseProtocol?, Error?) -> Void) -> URLSessionTaskProtocol {
        guard let request = request as? URLRequest else {
           return URLSessionTask()
        }
        return (dataTask(with: request, completionHandler: completionHandler) as URLSessionTask) as URLSessionTaskProtocol
    }
    
    func dataTask(with url: URL,
                         completionHandler: @escaping (Data?, URLResponseProtocol?, Error?) -> Void)
        -> URLSessionTaskProtocol {
            
            return (dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask) as  URLSessionTaskProtocol
    }
}


extension URLSessionTask: URLSessionTaskProtocol {
    
}

