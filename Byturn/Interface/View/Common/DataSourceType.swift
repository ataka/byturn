//
//  DataSource.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/10.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

protocol DataSourceType {
    associatedtype SectionType: DataSectionType
    var sections: [SectionType] { get }

    var numberOfSections: Int { get }
    func numberOfRows(in section: Int) -> Int
    func source(at indexPath: IndexPath) -> SectionType.RowType
}

extension DataSourceType {
    var numberOfSections: Int {
        return sections.count
    }

    func numberOfRows(in section: Int) -> Int {
        return sections[section].numberOfRows
    }

    func source(at indexPath: IndexPath) -> SectionType.RowType {
        return sections[indexPath.section].source(at: indexPath)
    }
}

protocol DataSectionType {
    associatedtype RowType
    var name: String { get }
    var rows: [RowType] { get }

    var numberOfRows: Int { get }
    func source(at: IndexPath) -> RowType
}

extension DataSectionType {
    var numberOfRows: Int {
        return rows.count
    }

    func source(at indexPath: IndexPath) -> RowType {
        return rows[indexPath.row]
    }
}

final class DataSource2d<T>: DataSourceType {
    typealias SectionType = DataSection<T>
    var sections: [SectionType]

    init(dataSource: [T]) {
        let sectionObject = DataSection<T>(rows: dataSource)
        sections = [sectionObject]
    }
}

final class DataSection<T>: DataSectionType {
    typealias RowType = T
    let name: String
    var rows: [RowType]

    init(name: String = "", rows: [RowType] = []) {
        self.name = name
        self.rows = rows
    }
}
