//
//  ContextUserDefaultsRepository.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/12.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

enum AppSettingType: String {
    case isRealmInitialized
}

struct AppSettingUserDefaultsRepository: UserDefaultsRepository {
    let client: UserDefaults

    func save(isRealmInitialized value: Bool) {
        client.set(value, forKey: AppSettingType.isRealmInitialized.rawValue)
    }

    func fetch(isRealmInitialized _: Void) -> Bool {
        guard let value = client.object(forKey: AppSettingType.isRealmInitialized.rawValue),
            let isRealmInitialized = value as? Bool else { return false }
        return isRealmInitialized
    }
}
