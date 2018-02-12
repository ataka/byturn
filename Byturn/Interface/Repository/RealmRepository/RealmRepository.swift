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
    associatedtype ModelObjectType: ModelObject, Identifiable

    var client: RealmClient { get }

    func convert(from model: ModelType) -> ModelObjectType?
    func convert(from modelObject: ModelObjectType) -> ModelType?

    func find(byIds ids: [ModelType.IdType]) -> [ModelType]
    func findAll() -> [ModelType]
    func save(_ models: [ModelType])
}

extension RealmRepository where ModelType.IdType: IdProtocol, ModelType.IdType.ValueType == ModelObjectType.IdType {
    func find(byIds ids: [ModelType.IdType]) -> [ModelType] {
        let idValues = ids.map { $0.value }
        let modelObjects = client.realm.objects(ModelObjectType.self).filter { idValues.contains($0.id) }
        return modelObjects.flatMap(convert)
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
