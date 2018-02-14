//
//  IdProtocol.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/12.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

// MARK: - Id Protocol

protocol IdProtocol: Hashable {
    associatedtype ValueType: Hashable
    var value: ValueType { get }
}

extension IdProtocol {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.value == rhs.value
    }
}

extension IdProtocol where ValueType == Int {
    var hashValue: Int {
        return value
    }
}

// MARK: - Comparable Id Protocol

protocol ComparableIdProtocol: IdProtocol, Comparable {
}

extension ComparableIdProtocol where ValueType == Int {
    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.value < rhs.value
    }
}

// MARK: - Struct

struct LocationId: ComparableIdProtocol {
    typealias ValueType = Int
    let value: Int
}

struct PersonId: ComparableIdProtocol {
    typealias ValueType = Int
    let value: Int
}
