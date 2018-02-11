//
//  Person.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/06.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

typealias PersonOrder = UInt

final class Person: Model {
    typealias IdType = PersonId

    let id: PersonId
    let locationId: LocationId
    let name: String
    let order: PersonOrder
    private(set) var records: [Date]

    init(id: PersonId, locationId: LocationId, name: String, order: PersonOrder, records: [Date]) {
        self.id = id
        self.locationId = locationId
        self.name = name
        self.order = order
        self.records = records
    }

    // Action

    func record(date: Date) {
        records.append(date)
    }

    // Domain Logic

    static func filterByName(_ person: Person, keywords: [String]) -> Bool {
        return keywords.contains { person.name.localizedStandardContains($0) }
    }

    static func filter(byLocation locationId: LocationId) -> (Person) -> Bool {
        return { $0.locationId == locationId }
    }
}
