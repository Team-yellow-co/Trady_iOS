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
        var reference = ref.collection(path)
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
                    guard let orderValue = $0.value as? String else { return }
                    switch type {
                    case .child:
                        reference = reference.order(by: orderValue)
                    case .key:
                        reference = reference.order(by: orderValue)
                    }
                case .equalTo:
                case .limitToLast:
                case .limitToFirst:
                case .startAt:
                case .endingAt:
                }
            }
        }
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
}
