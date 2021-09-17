//
//  LocationTag.swift
//  Trady
//
//  Created by USER on 2021/09/17.
//

import Foundation

class MasterLocationTag {
    let locationName: String
    let locationCode: Int
    var subLocations: [LocationTag]
    
    func addSubLocationTag(tag: LocationTag) {
        subLocations.append(tag)
    }
    
    init(locationName: String, locationCode: Int, subLocations: [LocationTag] = []) {
        self.locationName = locationName
        self.locationCode = locationCode
        self.subLocations = subLocations
    }
}

struct LocationTag: Equatable {
    static func == (lhs: LocationTag, rhs: LocationTag) -> Bool {
        return lhs.locationCode == rhs.locationCode
    }
    
    let motherLocation: MasterLocationTag
    let locationName: String
    let locationCode: Int
}
