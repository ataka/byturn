//
//  PersonListService.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/12.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

struct PersonListService {
    static func showPersonList(locationId: LocationId) -> [Person] {
        let allPeople = ApplicationContext.shared.personRealmRepository.findAll()
        return allPeople.filter(Person.filter(byLocation: locationId))
    }
}
