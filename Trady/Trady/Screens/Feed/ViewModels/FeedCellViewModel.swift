//
//  FeedCellViewModel.swift
//  Trady
//
//  Created by USER on 2021/07/16.
//

import Foundation

class FeedCellViewModel: Identifiable {
    private(set) var viewCountText: String = "1"
    private(set) var contentText: String = String.random(length: Int.random(in: 15...500))
}

extension String {

    static func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""

        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}
