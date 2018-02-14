//
//  Person.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/06.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

typealias PersonIndex = UInt

final class Person: Model, Decodable {
    typealias IdType = PersonId

    let id: PersonId
    let locationId: LocationId
    let name: String
    let index: PersonIndex
    private(set) var records: [Date]

    // MARK: - Initializer

    init(id: PersonId, locationId: LocationId, name: String, index: PersonIndex, records: [Date]) {
        self.id = id
        self.locationId = locationId
        self.name = name
        self.index = index
        self.records = records
    }

    // MARK: - Decodable

    private enum CodingKeys: String, CodingKey {
        case id
        case locationId
        case name
        case index
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let idValue = try container.decode(Int.self, forKey: .id)
        id = PersonId(value: idValue)
        let locationIdValue = try container.decode(Int.self, forKey: .locationId)
        locationId = LocationId(value: locationIdValue)
        name = try container.decode(String.self, forKey: .name)
        index = try container.decode(PersonIndex.self, forKey: .index)
        records = []
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

    // MARK: Sort

    typealias SortHandler = (_ lhs: Person, _ rhs: Person) -> Bool

    static func sort(byIndex _: Void) -> SortHandler {
        return { $0.index < $1.index }
    }
}
