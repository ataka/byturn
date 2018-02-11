//
//  PersonListViewModel.swift
//  Byturn
//
//  Created by 安宅 正之 on 2018/02/08.
//  Copyright © 2018年 WelltempRed. All rights reserved.
//

import Foundation
import RxCocoa

final class PersonListViewModel: ListViewModel {
    typealias DataSourceType = DataSource2d<PersonCellViewModel>
    let rawDataSource: DataSource2d<PersonCellViewModel>
    var dataSource: DataSource2d<PersonCellViewModel>
    let canSave: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var selectedCount: Int = 0 {
        didSet {
            canSave.accept(selectedCount > 0)
        }
    }

    init(locationId: LocationId) {
        rawDataSource = DataSource2d<PersonCellViewModel>
            .init(rows: PersonListService.showPersonList(locationId: locationId).map(PersonCellViewModel.init))
        dataSource = rawDataSource
    }

    // MARK: - Select

    func toggleSelect(person: PersonCellViewModel) {
        person.toggleSelect()
        selectedCount += person.isSelected ? +1 : -1
    }

    // MARK: - Action

    func record() {
        let selectedPeople = rawDataSource.filter { $0.isSelected }.map { $0.person }
        let date = Date()
        selectedPeople.forEach {
            $0.record(date: date)
        }
        ApplicationContext.shared.personRealmRepository.save(selectedPeople)
    }
}
