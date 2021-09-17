//
//  LocationService.swift
//  Trady
//
//  Created by USER on 2021/09/17.
//

import Foundation
import Combine

class LocationService: LocationServiceProtocol {
    func makeLocationTag() -> [MasterLocationTag] {
        let gyeongGiLocation = MasterLocationTag(locationName: "경기",
                                                locationCode: 031,
                                                subLocations: [])
        
        let gaPyeong = LocationTag(motherLocation: gyeongGiLocation,
                                   locationName: "가평",
                                   locationCode: 0356)
        let yangPyeong = LocationTag(motherLocation: gyeongGiLocation,
                                     locationName: "양평",
                                     locationCode: 0338)
        gyeongGiLocation.addSubLocationTag(tag: gaPyeong)
        gyeongGiLocation.addSubLocationTag(tag: yangPyeong)
        
        let gangWonLocation = MasterLocationTag(locationName: "강원",
                                                locationCode: 033,
                                                subLocations: [])
        let gangReung = LocationTag(motherLocation: gangWonLocation,
                                    locationName: "강릉",
                                    locationCode: 0391)
        let sokCho = LocationTag(motherLocation: gangWonLocation,
                                    locationName: "속초",
                                    locationCode: 0338)
        let yangYang = LocationTag(motherLocation: gangWonLocation,
                                   locationName: "양양",
                                   locationCode: 0396)
        let pyeongChang = LocationTag(motherLocation: gangWonLocation,
                                      locationName: "평창",
                                      locationCode: 0374)
        let taeBaek = LocationTag(motherLocation: gangWonLocation,
                                 locationName: "태백",
                                 locationCode: 0395)
        let samChuk = LocationTag(motherLocation: gangWonLocation,
                                  locationName: "삼척",
                                  locationCode: 0397)
        
        gangWonLocation.addSubLocationTag(tag: gangReung)
        gangWonLocation.addSubLocationTag(tag: sokCho)
        gangWonLocation.addSubLocationTag(tag: yangYang)
        gangWonLocation.addSubLocationTag(tag: pyeongChang)
        gangWonLocation.addSubLocationTag(tag: taeBaek)
        gangWonLocation.addSubLocationTag(tag: samChuk)
        
        let jeJuLocation = MasterLocationTag(locationName: "제주",
                                             locationCode: 064,
                                             subLocations: [])
        let aeWol = LocationTag(motherLocation: jeJuLocation,
                                locationName: "애월",
                                locationCode: 0641)
        let seoGuiPo = LocationTag(motherLocation: jeJuLocation,
                                   locationName: "서귀포",
                                   locationCode: 0642)
        let sungSan = LocationTag(motherLocation: jeJuLocation,
                                  locationName: "성산",
                                  locationCode: 0645)
        
        jeJuLocation.addSubLocationTag(tag: aeWol)
        jeJuLocation.addSubLocationTag(tag: seoGuiPo)
        jeJuLocation.addSubLocationTag(tag: sungSan)
        
        return [gyeongGiLocation, gangWonLocation, jeJuLocation]
    }
    
    func getLocationList() -> AnyPublisher<[MasterLocationTag], Error> {
        return Just(makeLocationTag())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
