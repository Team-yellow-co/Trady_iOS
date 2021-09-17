//
//  LocationServiceProtocol.swift
//  Trady
//
//  Created by USER on 2021/09/17.
//

import Foundation
import Combine

protocol LocationServiceProtocol {
    func getLocationList() -> AnyPublisher<[MasterLocationTag], Error>
}
