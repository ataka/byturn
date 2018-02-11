//
//  RepositoryManager.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/12.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

final class RepositoryManager {
    let realmIdentifier = "Byturn"
    let personRealmRepository: PersonRealmRepository

    init() {
        let realmClient = RealmClient(config: RealmClient.configuration(for: realmIdentifier))
        personRealmRepository = PersonRealmRepository(client: realmClient)
    }
}
