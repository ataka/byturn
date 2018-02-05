//
//  Id.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/06.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

protocol Id {
    associatedtype IdType: Hashable
    var id: IdType { get }
}

struct LocationId: Id {
    typealias IdType = Int
    let id: IdType
}

struct PersonId: Id {
    typealias IdType = Int
    let id: IdType
}
