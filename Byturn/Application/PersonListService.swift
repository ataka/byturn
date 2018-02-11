//
//  PersonListService.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/12.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

struct PersonListService {
    static func showPersonList(locationId: LocationId) -> [Person] {
        let peopleInRealm = ApplicationContext.shared.personRealmRepository.findAll()
        let people = peopleInRealm.isEmpty ? loadFromPlist() : peopleInRealm

        return people.filter { $0.locationId == locationId }
    }

    private static func loadFromPlist() -> [Person] {
        guard let path = Bundle.main.path(forResource: "Person", ofType: "plist"),
            let plist = NSArray(contentsOfFile: path) as? [[String: Any]] else { return [] }
        return plist.flatMap {
            guard let id = $0["id"] as? Int,
                let locationId = $0["locationId"] as? Int,
                let name = $0["name"] as? String,
                let order = $0["order"] as? PersonOrder else { return nil }
            return Person(id: PersonId(id: id), locationId: LocationId(id: locationId), name: name, order: order, turnAts: [])
        }
    }
}
