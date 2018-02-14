//
//  Location.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/06.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

final class Location: Model, Decodable {
    typealias IdType = LocationId

    let id: LocationId
    let name: String

    // MARK: - Initializer

    init(id: LocationId, name: String) {
        self.id = id
        self.name = name
    }

    // MARK: - Decodable

    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let idValue = try container.decode(Int.self, forKey: .id)
        id = LocationId(value: idValue)
        name = try container.decode(String.self, forKey: .name)
    }

    // MARK: - Domain Logic

    // MARK: Sort

    typealias SortHandler = (_ lhs: Location, _ rhs: Location) -> Bool

    static func sort(byId _: Void) -> SortHandler {
        return { $0.id < $1.id }
    }
}
