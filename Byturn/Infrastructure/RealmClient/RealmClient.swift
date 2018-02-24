//
//  RealmClient.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/11.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmClient {
    private let config: Realm.Configuration

    // MARK: - Initialization

    init(config: Realm.Configuration) {
        self.config = config
    }

    static func configuration(for identifier: String) -> Realm.Configuration {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(identifier).realm")
        return config
    }

    // MARK: - Realm

    var realm: Realm {
        return try! Realm(configuration: config)
    }
}
