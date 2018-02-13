//
//  PersonListService.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/12.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

struct PersonListService {
    typealias RecordCompletionHandler = ([Person]) -> Void

    static func showPersonList(locationId: LocationId) -> [Person] {
        let allPeople = ApplicationContext.shared.personRealmRepository.findAll()
        return allPeople.filter(Person.filter(byLocation: locationId))
    }

    static func record(personIds: [PersonId], comletionHandler: RecordCompletionHandler) {
        let personRepository = ApplicationContext.shared.personRealmRepository
        let people = personRepository.find(byIds: personIds)
        let date = Date()
        people.forEach {
            $0.record(date: date)
        }
        personRepository.save(people)

        comletionHandler(people)
    }
}
