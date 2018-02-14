//
//  Location.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/06.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

final class Location: Model {
    typealias IdType = LocationId

    let id: LocationId
    let name: String

    init(id: LocationId, name: String) {
        self.id = id
        self.name = name
    }

    // MARK: - Domain Logic

    // MARK: Sort

    typealias SortHandler = (_ lhs: Location, _ rhs: Location) -> Bool

    static func sort(byId _: Void) -> SortHandler {
        return { $0.id.value < $1.id.value }
    }
}
