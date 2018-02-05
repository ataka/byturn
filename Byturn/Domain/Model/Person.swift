//
//  Person.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/06.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

final class Person: Model {
    typealias IdType = PersonId

    let id: PersonId
    let name: String
    let locationId: LocationId

    init(id: PersonId, name: String, locationId: LocationId) {
        self.id = id
        self.name = name
        self.locationId = locationId
    }
}
