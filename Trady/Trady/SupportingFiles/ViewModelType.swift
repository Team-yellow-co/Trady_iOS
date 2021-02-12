//
//  ViewModelType.swift
//  Trady
//
//  Created by bumslap on 2021/02/13.
//

import Foundation
import Combine

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    mutating func transform(input: Input,
                   subscriptions: SubscriptionBag) -> Output
}
