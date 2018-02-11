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
    }

    // MARK: - Repository Utils

    var personRealmRepository: PersonRealmRepository {
        return repositoryManager.personRealmRepository
    }
}
