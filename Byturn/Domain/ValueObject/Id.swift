//
//  Id.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/06.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

protocol Id: Equatable {
    associatedtype IdType: Hashable
    var id: IdType { get }
}

extension Id {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

struct LocationId: Id {
    typealias IdType = Int
    let id: IdType
}

struct PersonId: Id {
    typealias IdType = Int
    let id: IdType
}
