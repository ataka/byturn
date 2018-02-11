//
//  RealmRepository.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/11.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

protocol RealmRepository: RepositoryProtocol {
    associatedtype ModelType: Model
    associatedtype ModelObjectType: ModelObject

    var client: RealmClient { get }

    func convert(from model: ModelType) -> ModelObjectType?
    func convert(from modelObject: ModelObjectType) -> ModelType?

    func find(byIds ids: [ModelType.IdType]) -> [ModelType]
    func findAll() -> [ModelType]
    func save(_ models: [ModelType])
}

extension RealmRepository {
    func find(byIds ids: [ModelType.IdType]) -> [ModelType] {
        let modelObjects = client.realm.objects(ModelObjectType.self)
        return modelObjects.flatMap(convert).filter { ids.contains($0.id) }
    }

    func findAll() -> [ModelType] {
        let modelObjects = client.realm.objects(ModelObjectType.self)
        return modelObjects.flatMap(convert)
    }

    func save(_ models: [ModelType]) {
        let modelObjects = models.flatMap(convert)
        try? client.realm.write {
            client.realm.add(modelObjects, update: true)
        }
    }
}
