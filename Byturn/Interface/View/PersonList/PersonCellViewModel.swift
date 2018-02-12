//
//  PersonCellViewModel.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/09.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

final class PersonCellViewModel {
    private let person: Person
    let personId: PersonId
    let name: String
    var isSelected: Bool = false
    let recordCount: Int

    init(person: Person) {
        self.person = person
        personId = person.id
        name = person.name
        recordCount = person.records.count
    }

    // MARK: - Selected

    func toggleSelect() {
        isSelected = !isSelected
    }

    // MARK: - Search

    static func filter(byName keywords: [String]) -> (_ personViewModel: PersonCellViewModel) -> Bool {
        return { Person.filter(byName: keywords)($0.person) }
    }
}
