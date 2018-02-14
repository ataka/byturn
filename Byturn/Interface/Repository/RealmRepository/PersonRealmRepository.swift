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
        return PersonObject(id: model.id.value,
                            locationId: model.locationId.value,
                            name: model.name,
                            index: Int(model.index),
                            records: model.records.reduce(into: List<Date>()) { $0.append($1) }
        )
    }

    func convert(from modelObject: PersonObject) -> Person? {
        return Person(id: PersonId(value: modelObject.id),
                      locationId: LocationId(value: modelObject.locationId),
                      name: modelObject.name,
                      index: UInt(modelObject.index),
                      records: Array<Date>(modelObject.records)
        )
    }
}
