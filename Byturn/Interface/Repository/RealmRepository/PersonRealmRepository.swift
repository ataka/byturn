//
//  PersonRealmRepository.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/11.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation
import RealmSwift

struct PersonRealmRepository: RealmRepository {
    typealias ModelType = Person
    typealias ModelObjectType = PersonObject

    let client: RealmClient

    // MARK: - Initializer

    init(client: RealmClient) {
        self.client = client
    }

    // MARK: - Convert

    func convert(from model: Person) -> PersonObject? {
        return PersonObject(id: model.id.id,
                            locationId: model.locationId.id,
                            name: model.name,
                            order: Int(model.order),
                            turnAts: model.turnAts.reduce(into: List<Date>()) { $0.append($1) }
        )
    }

    func convert(from modelObject: PersonObject) -> Person? {
        return Person(id: PersonId(id: modelObject.id),
                      locationId: LocationId(id: modelObject.locationId),
                      name: modelObject.name,
                      order: UInt(modelObject.order),
                      turnAts: Array<Date>(modelObject.turnAts)
        )
    }
}
