//
//  ListViewModel.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/10.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

protocol ListViewModel {
    associatedtype SourceType
    var dataSource: [SourceType] { get }
    func numberOfSections() -> Int
    func numberOfRows(at section: Int) -> Int
}

extension ListViewModel {
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(at section: Int) -> Int {
        return dataSource.count
    }
}
