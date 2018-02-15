//
//  PersonPlistRepository.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/15.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

struct PersonPlistRepository: PlistRepository {
    let bundle: Bundle
    let resource: String = "person"

    func findAll() -> [Person] {
        guard let data = data,
            let people = try? PropertyListDecoder().decode([Person].self, from: data) else { return [] }
        return people
    }
}
