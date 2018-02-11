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
    typealias Row = SectionType.RowType
    init(sections: [SectionType])
    var sections: [SectionType] { get }

    var numberOfSections: Int { get }
    func numberOfRows(in section: Int) -> Int
    func source(at indexPath: IndexPath) -> Row
    func filter(_ isIncluded: (_ row: Row) throws -> Bool) -> Self
    func map<T>(_ transform: (_ row: Row) throws -> T) rethrows -> [T]
}

extension DataSourceType {
    var numberOfSections: Int {
        return sections.count
    }

    func numberOfRows(in section: Int) -> Int {
        return sections[section].numberOfRows
    }

    func source(at indexPath: IndexPath) -> Row {
        return sections[indexPath.section].source(at: indexPath)
    }

    func filter(_ isIncluded: (_ row: Row) throws -> Bool) -> Self {
        return Self(sections: sections.flatMap { $0.filter(isIncluded) })
    }

    func map<T>(_ transform: (_ row: Row) throws -> T) rethrows -> [T] {
        return sections.flatMap { (try? $0.map(transform)) ?? [] }
    }
}

protocol DataSectionType {
    associatedtype RowType
    init(name: String, rows: [RowType])
    var name: String { get }
    var rows: [RowType] { get }

    var numberOfRows: Int { get }
    func source(at: IndexPath) -> RowType
    func filter(_ isIncluded: (_ row: RowType) throws -> Bool) -> Self?
    func map<T>(_ transform: (_ row: RowType) throws -> T) rethrows -> [T]
}

extension DataSectionType {
    var numberOfRows: Int {
        return rows.count
    }

    func source(at indexPath: IndexPath) -> RowType {
        return rows[indexPath.row]
    }

    func filter(_ isIncluded: (_ row: RowType) throws -> Bool) -> Self? {
        let rows = (try? self.rows.filter(isIncluded)) ?? []
        return rows.isEmpty ? nil : Self(name: name, rows: rows)
    }

    func map<T>(_ transform: (_ row: RowType) throws -> T) rethrows -> [T] {
        return (try? rows.map(transform)) ?? []
    }
}

final class DataSource2d<Source>: DataSourceType {
    typealias SectionType = DataSection<Source>
    var sections: [SectionType]

    init(sections: [SectionType]) {
        self.sections = sections
    }

    convenience init(section: SectionType) {
        self.init(sections: [section])
    }

    convenience init(rows: [Source]) {
        self.init(section: DataSection<Source>(rows: rows))
    }

    /// Alias initializer of init(rows:)
    ///
    /// - Parameter sources: Array of source (aka. row)
    convenience init(sources: [Source]) {
        self.init(rows: sources)
    }
}

final class DataSection<Source>: DataSectionType {
    typealias RowType = Source
    let name: String
    var rows: [RowType]

    init(name: String = "", rows: [RowType] = []) {
        self.name = name
        self.rows = rows
    }
}
