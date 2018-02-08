//
//  PersonListViewModel.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/08.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

final class PersonListViewModel {
    let people: [Person]
    
    init() {
        self.people = PersonListViewModel.loadPeople()
    }
    
    // Preparation
    
    private static func loadPeople() -> [Person] {
        guard let path = Bundle.main.path(forResource: "Person", ofType: "plist"),
            let plist = NSArray(contentsOfFile: path) as? [[String: Any]] else { return [] }
        return plist.flatMap {
            guard let id = $0["id"] as? Int,
                let locationId = $0["locationId"] as? Int,
                let name = $0["name"] as? String,
                let order = $0["order"] as? PersonOrder else { return nil }
            return Person.init(id: PersonId(id: id), locationId: LocationId(id: locationId), name: name, order: order, turnAts: [])
    }
}
