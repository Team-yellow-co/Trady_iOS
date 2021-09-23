//
//  LocationTag.swift
//  Trady
//
//  Created by USER on 2021/09/17.
//

import Foundation

class MasterLocationTag: Identifiable, Hashable {
    static func == (lhs: MasterLocationTag, rhs: MasterLocationTag) -> Bool {
        return lhs.locationCode == rhs.locationCode
    }
    
    let locationName: String
    let locationCode: Int
    var subLocations: [LocationTag]
    var id: Int {
        return locationCode
    }
    
    func addSubLocationTag(tag: LocationTag) {
        subLocations.append(tag)
    }
    
    init(locationName: String, locationCode: Int, subLocations: [LocationTag] = []) {
        self.locationName = locationName
        self.locationCode = locationCode
        self.subLocations = subLocations
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct LocationTag: Equatable, Identifiable, Hashable, Comparable {
    static func < (lhs: LocationTag, rhs: LocationTag) -> Bool {
        lhs.locationName < rhs.locationName
    }
    
    var id: Int {
        return locationCode
    }
    
    static func == (lhs: LocationTag, rhs: LocationTag) -> Bool {
        return lhs.locationCode == rhs.locationCode
    }
    
    let motherLocation: MasterLocationTag
    let locationName: String
    let locationCode: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
