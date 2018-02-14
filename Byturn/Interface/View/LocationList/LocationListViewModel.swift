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
        rawDataSource = DataSource2d<Location>(rows: LocationListViewModel.loadLocation().sorted(by: Location.sort(byId: ())))
        dataSource = rawDataSource
    }

    // Preparation

    private static func loadLocation() -> [Location] {
        guard let url = Bundle.main.url(forResource: "Location", withExtension: "plist"),
            let data = try? Data(contentsOf: url),
            let locations = try? PropertyListDecoder().decode([Location].self, from: data) else { return [] }
        return locations
    }
}
