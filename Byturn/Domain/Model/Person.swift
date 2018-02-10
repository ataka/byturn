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
    private(set) var turnAts: [Date]

    init(id: PersonId, locationId: LocationId, name: String, order: PersonOrder, turnAts: [Date]) {
        self.id = id
        self.locationId = locationId
        self.name = name
        self.order = order
        self.turnAts = turnAts
    }

    // Action

    func recordTurn() {
        turnAts.append(Date())
    }
}
