//
//  FireStoreServer.swift
//  Trady
//
//  Created by USER on 2021/03/01.
//

import Foundation
import FirebaseFirestore
import Combine

class FireStoreServer: Network {
    
    let phaseManager = AppPhaseManager.shared
    let ref = Firestore.firestore()
    
    func dispatch(request: URLRequestProtocol,
                  completion: @escaping (Result<Data?, Error>) -> Void) {
        let path = phaseManager.currentPhase == .dev ? "dev/" + request.path : request.path
        var reference = ref.collection(path)
        
        switch request.kind {
        case .observe:
            reference.addSnapshotListener { snapshot, error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                let objects = snapshot?.documents.compactMap { $0.data() } ?? []
                if let data = try? JSONSerialization.data(withJSONObject: objects, options: .prettyPrinted) {
                    completion(.success(data))
                } else {
                    completion(.failure(APIError.jsonConversionFailure))
                }
            }
        case .observeSingleEvent:
            reference.getDocuments { snapshot, error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                let objects = snapshot?.documents.compactMap { $0.data() } ?? []
                if let data = try? JSONSerialization.data(withJSONObject: objects, options: .prettyPrinted) {
                    completion(.success(data))
                } else {
                    completion(.failure(APIError.jsonConversionFailure))
                }
            }
        case .set:
            guard let body = request.body as? [String: Any] else { return }
            reference.document().setData(body) { (error) in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                completion(.success(nil))
            }
        case .setUnderAutoId:
            break
        case .update:
            break
        case .updateByTransaction(let actionType):
            break //TODO: 구현
        case .remove:
            break
        case .storageUpload(let data):
            break
        }
    }
    
    func dispatch(request: URLRequestProtocol) -> AnyPublisher<Data?, Error> {
        let path = phaseManager.currentPhase == .dev ? "dev/" + request.path : request.path
        var reference: FirebaseFirestore.Query = ref.collection(path)
        
        if let queries = request.queries {
            queries.forEach {
                switch $0.kind {
                case .orderBy(let type):
                    guard let orderValue = $0.value as? String else { return }
                    switch type {
                    case .child:
                        reference = reference.order(by: orderValue)
                    case .key:
                        reference = reference.order(by: orderValue)
                    }
                case .whereField(let type):
                    guard let targetValue = $0.value as? String else { return }
                    switch type {
                    case .array(let key):
                        reference = reference.whereField(key, arrayContains: targetValue)
                    case .element(let key):
                        reference = reference.whereField(key, isEqualTo: targetValue)
                    }
                case .limitToLast:
                    guard let targetValue = $0.value as? Int else { return }
                    reference = reference.limit(toLast: targetValue)
                case .limitToFirst:
                    guard let targetValue = $0.value as? Int else { return }
                    reference = reference.limit(to: targetValue)
                case .startAt:
                    guard let targetValue = $0.value as? Int else { return }
                    //reference = reference.start(atDocument: <#T##DocumentSnapshot#>)
                case .endingAt:
                    guard let targetValue = $0.value as? Int else { return }
                    //reference = reference.end(atDocument: <#T##DocumentSnapshot#>)
                }
            }
        }
        switch request.kind {
        case .observe:
            return Future<Data?, Error> { promise in
                reference.addSnapshotListener { snapshot, error in
                    if let error = error {
                        promise(.failure(error))
                        return
                    }
                    
                    let objects = snapshot?.documents.compactMap { $0.data() } ?? []
                    if let data = try? JSONSerialization.data(withJSONObject: objects,
                                                              options: .prettyPrinted) {
                        promise(.success(data))
                    } else {
                        promise(.failure(APIError.jsonConversionFailure))
                    }
                }
            }
            .eraseToAnyPublisher()
        case .observeSingleEvent:
            return Future<Data?, Error> { promise in
                reference.getDocuments { snapshot, error in
                    if let error = error {
                        promise(.failure(error))
                        return
                    }
                    
                    let objects = snapshot?.documents.compactMap { $0.data() } ?? []
                    if let data = try? JSONSerialization.data(withJSONObject: objects, options: .prettyPrinted) {
                        promise(.success(data))
                    } else {
                        promise(.failure(APIError.jsonConversionFailure))
                    }
                }
            }
            .eraseToAnyPublisher()
        case .set:
            return Future<Data?, Error> { promise in
                guard let body = request.body as? [String: Any],
                      let document = (reference as? CollectionReference)?.document(path) else {
                    return promise(.failure(APIError.notDefined))
                }
                document.setData(body) { (error) in
                    
                    if let error = error {
                        promise(.failure(error))
                        return
                    }
                    promise(.success(nil))
                }
            }
            .eraseToAnyPublisher()
        case .setUnderAutoId:
            return Empty().eraseToAnyPublisher()
        case .update:
            return Empty().eraseToAnyPublisher()
        case .updateByTransaction(let actionType):
            return Empty().eraseToAnyPublisher() //TODO: 구현
        case .remove:
            return Empty().eraseToAnyPublisher()
        case .storageUpload(let data):
            return Empty().eraseToAnyPublisher()
        }
    }
}
