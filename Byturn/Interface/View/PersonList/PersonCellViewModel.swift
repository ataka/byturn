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
    var isSelected: Bool = false

    init(person: Person) {
        self.person = person
    }

    // MARK: - Computed Property

    var name: String {
        return person.name
    }

    // MARK: - Selected

    func toggleSelect() {
        isSelected = !isSelected
    }
}
