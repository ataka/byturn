//
//  LocationPlistRepository.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/15.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

struct LocationPlistRepository: PlistRepository {
    let bundle: Bundle
    let resource: String = "Location"

    func findAll() -> [Location] {
        guard let data = data,
            let locations = try? PropertyListDecoder().decode([Location].self, from: data) else { return [] }
        return locations
    }
}
