//
//  Person.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/06.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

typealias PersonIndex = UInt

final class Person: Model {
    typealias IdType = PersonId

    let id: PersonId
    let locationId: LocationId
    let name: String
    let index: PersonIndex
    private(set) var turnAts: [Date]

    init(id: PersonId, locationId: LocationId, name: String, index: PersonIndex) {
        self.id = id
        self.locationId = locationId
        self.name = name
        self.index = index
    }
}
