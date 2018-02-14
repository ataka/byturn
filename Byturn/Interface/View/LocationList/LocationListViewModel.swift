//
//  LocationListViewModel.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/07.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

final class LocationListViewModel: ListViewModel {
    typealias DataSource = DataSource2d<Location>

    let rawDataSource: DataSource2d<Location>
    var dataSource: DataSource2d<Location>

    init() {
        let locations = LocationPlistRepository(bundle: Bundle.main).findAll().sorted(by: Location.sort(byId: ()))
        rawDataSource = DataSource2d<Location>(rows: locations)
        dataSource = rawDataSource
    }
}
