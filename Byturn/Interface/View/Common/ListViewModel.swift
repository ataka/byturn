//
//  ListViewModel.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/10.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

protocol ListViewModel {
    associatedtype DataSource: DataSourceType
    typealias Source = DataSource.SectionType.RowType
    var rawDataSource: DataSource { get }
    var dataSource: DataSource { get set }
    var numberOfSections: Int { get }
    func numberOfRows(at section: Int) -> Int
    func source(at indexPath: IndexPath) -> Source
    mutating func search(by keywords: [String], where predicate: (_ source: Source, _ keywords: [String]) -> Bool)
}

extension ListViewModel {
    var numberOfSections: Int {
        return dataSource.numberOfSections
    }

    func numberOfRows(at section: Int) -> Int {
        return dataSource.numberOfRows(in: section)
    }

    func source(at indexPath: IndexPath) -> Source {
        return dataSource.source(at: indexPath)
    }

    mutating func search(by keywords: [String], where predicate: (_ source: Source, _ keywords: [String]) -> Bool) {
        if keywords.isEmpty {
            dataSource = rawDataSource
        } else {
            dataSource = rawDataSource.filter { predicate($0, keywords) }
        }
    }
}
