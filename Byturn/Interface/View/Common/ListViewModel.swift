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
    var dataSource: DataSource { get }
    var numberOfSections: Int { get }
    func numberOfRows(at section: Int) -> Int
    func source(at indexPath: IndexPath) -> DataSource.SectionType.RowType
}

extension ListViewModel {
    var numberOfSections: Int {
        return dataSource.numberOfSections
    }

    func numberOfRows(at section: Int) -> Int {
        return dataSource.numberOfRows(in: section)
    }

    func source(at indexPath: IndexPath) -> DataSource.SectionType.RowType {
        return dataSource.source(at: indexPath)
    }
}
