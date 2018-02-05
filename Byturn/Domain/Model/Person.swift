//
//  Person.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/06.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

final class Person: Model {
    let id: Int
    let name: String

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
