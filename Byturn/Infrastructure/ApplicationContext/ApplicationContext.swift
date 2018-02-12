//
//  ApplicationContext.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/12.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

final class ApplicationContext {
    static let shared: ApplicationContext = ApplicationContext()
    let repositoryManager: RepositoryManager

    private init() {
        repositoryManager = RepositoryManager()
        initializeRealm()
    }

    // MARK: - Preparation

    private func initializeRealm() {
        let appSettingUserDefaultsRepository = AppSettingUserDefaultsRepository(client: UserDefaults.standard)
        let isRealmInitialized = appSettingUserDefaultsRepository.fetch(isRealmInitialized: ())
        if isRealmInitialized {
            return
        }

        // Initialize Realm
        let people = loadFromPlist()
        personRealmRepository.save(people)

        appSettingUserDefaultsRepository.save(isRealmInitialized: true)
    }

    private func loadFromPlist() -> [Person] {
        guard let path = Bundle.main.path(forResource: "Person", ofType: "plist"),
            let plist = NSArray(contentsOfFile: path) as? [[String: Any]] else { return [] }
        return plist.flatMap {
            guard let id = $0["id"] as? Int,
                let locationId = $0["locationId"] as? Int,
                let name = $0["name"] as? String,
                let order = $0["order"] as? PersonOrder else { return nil }
            return Person(id: PersonId(value: id), locationId: LocationId(value: locationId), name: name, order: order, records: [])
        }
    }

    // MARK: - Repository Utils

    var personRealmRepository: PersonRealmRepository {
        return repositoryManager.personRealmRepository
    }
}
