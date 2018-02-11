//
//  PersonCellViewModel.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/09.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation

final class PersonCellViewModel {
    let person: Person
    var isSelected: Bool = false

    init(person: Person) {
        self.person = person
        isSelected = !person.turnAts.isEmpty
    }

    // MARK: - Computed Property

    var name: String {
        return person.name
    }

    // MARK: - Selected

    func toggleSelect() {
        isSelected = !isSelected
    }

    // MARK: - Search

    static func filterByName(keywords: [String]) -> (_ personCellViewModel: PersonCellViewModel) -> Bool {
        return { Person.filterByName($0.person, keywords: keywords) }
    }
}
