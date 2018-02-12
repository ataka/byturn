//
//  UserObject.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/11.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation
import RealmSwift

class PersonObject: ModelObject, Identifiable {
    typealias IdType = Int

    @objc dynamic var id: Int = 0
    @objc dynamic var locationId: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var order: Int = 0
    var records = List<Date>()

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(id: Int,
                     locationId: Int,
                     name: String,
                     order: Int,
                     records: List<Date>) {
        self.init()
        self.id = id
        self.locationId = locationId
        self.name = name
        self.order = order
        self.records = records
    }
}
