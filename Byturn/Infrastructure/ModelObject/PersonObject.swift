//
//  UserObject.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/11.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation
import RealmSwift

class PersonObject: ModelObject {
    @objc dynamic var id: Int = 0
    @objc dynamic var locationId: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var order: Int = 0
    var turnAts = List<Date>()

    convenience init(id: Int,
                     locationId: Int,
                     name: String,
                     order: Int,
                     turnAts: List<Date>) {
        self.init()
        self.id = id
        self.locationId = locationId
        self.name = name
        self.order = order
        self.turnAts = turnAts
    }
}
