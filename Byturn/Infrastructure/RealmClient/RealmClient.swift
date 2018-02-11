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
    let realm: Realm

    init(config: Realm.Configuration) {
        realm = try! Realm(configuration: config)
    }

    static func configuration(for identifier: String) -> Realm.Configuration {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(identifier).realm")
        return config
    }
}
