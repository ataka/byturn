//
//  PlistRepository.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/15.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

protocol PlistRepository: RepositoryProtocol {
    var bundle: Bundle { get }
    var resource: String { get }
    var data: Data? { get }
}

extension PlistRepository {
    var data: Data? {
        guard let url = bundle.url(forResource: resource, withExtension: "plist"),
            let data = try? Data(contentsOf: url) else {
            return nil
        }
        return data
    }
}
