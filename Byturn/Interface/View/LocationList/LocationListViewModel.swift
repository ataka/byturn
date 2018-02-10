//
//  LocationListViewModel.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/07.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

final class LocationListViewModel: ListViewModel {
    typealias SourceType = Location
    let dataSource: [Location]
    init() {
        self.dataSource = LocationListViewModel.loadLocation()
    }
    
    // Preparation
    
    private static func loadLocation() -> [Location] {
        guard let path = Bundle.main.path(forResource: "Location", ofType: "plist"),
            let plist = NSArray(contentsOfFile: path) as? [[String: Any]] else { return [] }
        return plist.flatMap {
            guard let id = $0["id"] as? Int,
                let name = $0["name"] as? String else { return nil }
            return Location(id: LocationId(id: id), name: name)
        }
    }
}
