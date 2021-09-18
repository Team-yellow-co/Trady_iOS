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
        
        let chungcheongLocation = MasterLocationTag(locationName: "충청도",
                                                    locationCode: 040,
                                                    subLocations: [])
        let jaeCheon = LocationTag(motherLocation: chungcheongLocation,
                                   locationName: "제천",
                                   locationCode: 0443)
        let danYang = LocationTag(motherLocation: chungcheongLocation,
                                   locationName: "단양",
                                   locationCode: 0444)
        let dangJin = LocationTag(motherLocation: chungcheongLocation,
                                  locationName: "당진",
                                  locationCode: 0457)
        
        chungcheongLocation.addSubLocationTag(tag: jaeCheon)
        chungcheongLocation.addSubLocationTag(tag: danYang)
        chungcheongLocation.addSubLocationTag(tag: dangJin)
        
        let jeollaLocation = MasterLocationTag(locationName: "전라도",
                                               locationCode: 060,
                                               subLocations: [])
        
        let jeonJu = LocationTag(motherLocation: jeollaLocation,
                                 locationName: "전주",
                                 locationCode: 0652)
        let gunSan = LocationTag(motherLocation: jeollaLocation,
                                 locationName: "군산",
                                 locationCode: 0654)
        let haeNam = LocationTag(motherLocation: jeollaLocation,
                                 locationName: "해남",
                                 locationCode: 0634)
        let sunCheon = LocationTag(motherLocation: jeollaLocation,
                                   locationName: "순천",
                                   locationCode: 0661)
        let yeoSu = LocationTag(motherLocation: jeollaLocation,
                                locationName: "여수",
                                locationCode: 0662)
        let boSeong = LocationTag(motherLocation: jeollaLocation,
                                  locationName: "보성",
                                  locationCode: 0694)
        
        jeollaLocation.addSubLocationTag(tag: jeonJu)
        jeollaLocation.addSubLocationTag(tag: gunSan)
        jeollaLocation.addSubLocationTag(tag: haeNam)
        jeollaLocation.addSubLocationTag(tag: sunCheon)
        jeollaLocation.addSubLocationTag(tag: yeoSu)
        jeollaLocation.addSubLocationTag(tag: boSeong)
        
        
        let gyeongSangLocation = MasterLocationTag(locationName: "경상도",
                                                   locationCode: 050,
                                                   subLocations: [])
        let poHang = LocationTag(motherLocation: gyeongSangLocation,
                                 locationName: "포항",
                                 locationCode: 0562)
        let gyoungJu = LocationTag(motherLocation: gyeongSangLocation,
                                 locationName: "경주",
                                 locationCode: 0561)
        let ulReung = LocationTag(motherLocation: gyeongSangLocation,
                                 locationName: "울릉",
                                 locationCode: 0566)
        let anDong = LocationTag(motherLocation: gyeongSangLocation,
                                   locationName: "안동",
                                   locationCode: 0571)
        let ulSan = LocationTag(motherLocation: gyeongSangLocation,
                                locationName: "울산",
                                locationCode: 0522)
        let goSeong = LocationTag(motherLocation: gyeongSangLocation,
                                  locationName: "고성",
                                  locationCode: 0556)
        
        gyeongSangLocation.addSubLocationTag(tag: poHang)
        gyeongSangLocation.addSubLocationTag(tag: gyoungJu)
        gyeongSangLocation.addSubLocationTag(tag: ulReung)
        gyeongSangLocation.addSubLocationTag(tag: anDong)
        gyeongSangLocation.addSubLocationTag(tag: ulSan)
        gyeongSangLocation.addSubLocationTag(tag: goSeong)
        
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
        
        return [gyeongGiLocation,
                gangWonLocation,
                chungcheongLocation,
                jeollaLocation,
                gyeongSangLocation,
                jeJuLocation]
    }
    
    func getLocationList() -> AnyPublisher<[MasterLocationTag], Error> {
        return Just(makeLocationTag())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
