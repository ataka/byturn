//
//  LocationListViewModel.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/07.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

final class LocationListViewModel {
    let locations: [Location]
    
    init() {
        self.locations = LocationListViewModel.loadLocation()
    }
    
    // Preparation
    
    private static func loadLocation() -> [Location] {
        let locationA = Location(id: LocationId(id: 0), name: "Location A")
        let locationB = Location(id: LocationId(id: 1), name: "Location B")
        return [locationA, locationB]
    }
}
