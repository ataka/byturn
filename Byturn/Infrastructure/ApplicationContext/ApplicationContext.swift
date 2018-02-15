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
        let people = PersonPlistRepository(bundle: Bundle.main).findAll()
        personRealmRepository.save(people)

        appSettingUserDefaultsRepository.save(isRealmInitialized: true)
    }

    // MARK: - Repository Utils

    var personRealmRepository: PersonRealmRepository {
        return repositoryManager.personRealmRepository
    }
}
