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

    // MARK: - Domain Logic

    // MARK: Action

    func record(date: Date) {
        records.append(date)
    }

    // MARK: Filter

    /// Filter handler
    ///
    /// - Parameter person: Person
    /// - Returns: true if match the filter condition
    typealias FilterHandler = (_ person: Person) -> Bool

    static func filter(byName keywords: [String]) -> FilterHandler {
        return { person in keywords.contains { person.name.localizedStandardContains($0) } }
    }

    static func filter(byLocation locationId: LocationId) -> FilterHandler {
        return { $0.locationId == locationId }
    }
}
